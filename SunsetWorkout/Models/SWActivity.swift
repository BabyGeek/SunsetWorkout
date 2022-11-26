//
//  SWActivity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 27/10/2022.
//

import Foundation
import HealthKit

class SWActivity: ObservableObject {
    // MARK: - Constants
    static let START_TIMER_DURATION: Float = 5
    static let MINUTES_BY_INTERVAL: Double = 5

    // MARK: - Properties
    let cantStepOverState: [SWActivityState] = [.initialized, .starting, .paused, .canceled, .finished]
    let workout: SWWorkout
    var startDate: Date = Date()
    var endDate: Date = Date()
    var events: [HKWorkoutEvent] = []
    var nextExerciseOrder: Int = 0
    var lastState: SWActivityState
    var energyBurnedPerMinutes: Double?
    var workoutBuilder: HKWorkoutBuilder?
    var query: HKQuery?
    var healthStoreManager = SWHealthStoreManager()

    // MARK: - Published properties
    @Published var exerciseHasChanged: Bool = false
    @Published var state: SWActivityState
    @Published var currentExercise: SWExercise?
    @Published var nextExercise: SWExercise?
    @Published var currentExerciseRepetition: Int = 0
    @Published var totalExerciseRepetition: Int = 0
    @Published var currentExerciseEndBreak: Float = 0
    @Published var nextExerciseEndBreak: Float = 0
    @Published var currentExerciseBreak: Float = 0
    @Published var goal: Float = 0
    @Published var error: SWError?
    @Published var workoutInputs: [String: [[String: Any]]] = [:]

    // MARK: - Computed properties
    var duration: Double {
        endDate.timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate
    }

    var totalEnergyBurned: Double {
        ((energyBurnedPerMinutes ?? 0) * (duration / 60))
    }

    init(workout: SWWorkout,
         state: SWActivityState? = nil) {
        self.workout = workout
        self.state = state ?? .initialized
        self.lastState = state ?? .initialized
    }

    func inBreak() {
        if exerciseHasChanged {
            if currentExerciseEndBreak > 0 {
                state = .inBreak
            }
        } else if currentExerciseBreak > 0 {
            state = .inBreak
        }
    }

    func start() {
        state = .starting
    }

    func pause() {
        lastState = state
        state = .paused
        events.append(HKWorkoutEvent(type: .pause, dateInterval: DateInterval(), metadata: nil))
    }

    func run() {
        if state == .paused {
            state = lastState
            events.append(HKWorkoutEvent(type: .resume, dateInterval: DateInterval(), metadata: nil))
        } else {
            state = .running
        }
    }

    func cancel() {
        state = .canceled
    }

    func finish() {
        state = .finished
    }

    /// End the activity, set state to cancel if canceled is set to true
    /// - Parameter canceled: `Bool`
    func endActivity(canceled: Bool = false) {
        if state == .finished || state == .canceled {
            return
        }

        currentExercise = nil
        endDate = Date()

        if !canceled {
            self.finish()
        } else {
            self.cancel()
        }

        endWorkoutBuilder()
    }

    /// Get the next activity step
    func getNext() {
        switch state {
        case .initialized:
            initFirstExercise()
        case .starting, .paused:
            break
        case .canceled:
            endActivity(canceled: true)
        case .finished:
            endActivity()
        case .running, .inBreak:
            increaseExerciseRepetition()
            if currentExerciseRepetition > totalExerciseRepetition {
                if nextExercise == nil || workout.isLastExercise(currentExercise) {
                    endActivity()
                    return
                } else {
                    changeExercise()
                }
            }
        }

        if exerciseHasChanged {
            getMetadataForCurrentExercise()
        }
    }

    /// Init the first exercise
    func initFirstExercise() {
        exerciseHasChanged = true
        nextExerciseOrder = 2
        currentExerciseRepetition = 1
        currentExercise = workout.getFirstExercise()
        nextExercise = workout.getExerciseOrder(nextExerciseOrder)
        currentExerciseEndBreak = nextExerciseEndBreak
        start()
        startDate = Date()
        beginCollection()
    }

    /// Increase the current repetition
    func increaseExerciseRepetition() {
        exerciseHasChanged = false
        currentExerciseRepetition += 1
        inBreak()
    }

    /// Change the current exercise
    func changeExercise() {
        exerciseHasChanged = true
        nextExerciseOrder += 1
        currentExerciseRepetition = 1
        currentExerciseEndBreak = nextExerciseEndBreak
        currentExercise = nextExercise
        nextExercise = workout.getExerciseOrder(nextExerciseOrder)
        inBreak()
    }

    /// Get metadata for the current exercise
    func getMetadataForCurrentExercise() {
        currentExercise?.getMetadataFor(workout.type) { (exerciseEndBreak, exerciseBreak, exerciseRepetition, goal) in
            self.nextExerciseEndBreak = exerciseEndBreak ?? 0
            self.currentExerciseBreak = exerciseBreak ?? 0
            self.totalExerciseRepetition = exerciseRepetition ?? 0
            self.goal = goal ?? 0
        }
    }

    /// Know if the activity should have a time
    /// - Returns: `Bool`
    func shouldHaveTimer() -> Bool {
        switch state {
        case .finished, .canceled, .paused:
            return false
        case .inBreak, .starting:
            return true
        case .running:
            return workout.type == .highIntensityIntervalTraining
        default:
            return false
        }
    }

    /// Know if the activity is waiting for an input
    /// - Returns: `Bool`
    func isWaitingForInput() -> Bool {
        switch state {
        case .running:
            return workout.type == .traditionalStrengthTraining
        default:
            return false
        }
    }

    /// Add an input to the activity for the summary data
    /// - Parameter inputPrepared: `[String: Any]`
    func addInput(_ inputPrepared: [String: Any]) {
        if cantStepOverState.contains(state) { return }
        guard let exerciseID = inputPrepared["exerciseID"] as? String, exerciseID != "0" else { return }
        var inputMutable = inputPrepared
        inputMutable.removeValue(forKey: "exerciseID")

        if workoutInputs[exerciseID] != nil {
            workoutInputs[exerciseID]!.append(inputMutable)
        } else {
            workoutInputs[exerciseID] = [inputMutable]
        }
    }

    /// Get the summary model from the current activity
    /// - Returns: `SWActivitySummary`
    func getSummary() -> SWActivitySummary {
        SWActivitySummary(
            workout: workout,
            type: workout.type,
            inputs: workoutInputs,
            startDate: startDate,
            endDate: endDate,
            duration: duration,
            totalEnergyBurned: totalEnergyBurned,
            events: events,
            endedWithState: state
        )
    }
}

// MARK: - Workout builder
extension SWActivity {
    /// Began the healthkit workout builder
    private func beginCollection() {
        calculateActivityEnergyBurnedPerMinute()
        if let store = healthStoreManager.store {
            let workoutConfiguration = HKWorkoutConfiguration()
            workoutConfiguration.activityType = workout.type.HKWorkoutActivityType

            workoutBuilder = .init(healthStore: store, configuration: workoutConfiguration, device: .local())
            workoutBuilder?.beginCollection(withStart: startDate, completion: { _, error in
                if let error {
                    self.error = SWError(error: error)
                }
            })
        }
    }

    /// End HealthKit workout builder
    private func endWorkoutBuilder() {
        addBuilderEvents()
        addWorkoutBuilderSamples(getWorkoutActiveEnergySamples())
        endBuilder()
    }

    /// Add samples to healthkit workout builder
    /// - Parameter samples: `[HKSample]`
    private func addWorkoutBuilderSamples(_ samples: [HKSample]) {
        workoutBuilder?.add(samples, completion: { _, error in
            if let error {
                self.error = SWError(error: error)
            }
        })
    }

    /// Add events to the healthkit workout builder
    private func addBuilderEvents() {
        if events.isEmpty { return }

        workoutBuilder?.addWorkoutEvents(events, completion: { _, error in
            if let error {
                self.error = SWError(error: error)
            }
        })
    }

    /// Add metadata calories to the healthkit workout builder
    private func getWorkoutActiveEnergySamples() -> [HKSample] {
        var samples: [HKSample] = []

        if let quantityActiveEnergyBurnedType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
            let energyBurnedPerMinutes {
            let samplesIntervals = getIntervals(
                fromStart: startDate,
                toEnd: endDate,
                component: .minute,
                value: 5)
            let lastSample = samplesIntervals.last
            for index in samplesIntervals.indices {
                if samplesIntervals[index] == lastSample {
                    let lastTimeInterval = DateInterval(start: samplesIntervals[index], end: endDate).duration / 60
                    let quantityDouble = ceil(energyBurnedPerMinutes * lastTimeInterval)
                    let sample = HKQuantitySample(
                        type: quantityActiveEnergyBurnedType,
                        quantity: .init(unit: .kilocalorie(), doubleValue: quantityDouble),
                        start: samplesIntervals[index],
                        end: endDate)
                    samples.append(sample)
                } else {
                    let quantityDouble = ceil(energyBurnedPerMinutes * Self.MINUTES_BY_INTERVAL)
                    let sample = HKQuantitySample(
                        type: quantityActiveEnergyBurnedType,
                        quantity: .init(unit: .kilocalorie(), doubleValue: quantityDouble),
                        start: samplesIntervals[index],
                        end: samplesIntervals[index + 1])
                    samples.append(sample)
                }
            }
        }

        return samples
    }

    /// End the workout builder collection and finish the workout to save in healthkit
    private func endBuilder() {
        workoutBuilder?.endCollection(withEnd: endDate, completion: { success, error in
            if let error {
                self.error = SWError(error: error)
                return
            }

            if !success {
                self.error = SWError(error: SWHealthKitError.collectionEndFailure)
                return
            }

            self.workoutBuilder?.finishWorkout(completion: { workout, error in
                if workout == nil {
                    self.error = SWError(error: SWHealthKitError.notSaved)
                }

                if let error {
                    self.error = SWError(error: error)
                    return
                }
            })
        })
    }

    /// Get the date intervals depending on the component used and the value of intervals
    /// - Parameters:
    ///   - start: `Date`
    ///   - end: `Date`
    ///   - component: `Calendar.Component` the  interval component to use
    ///   - value: `Int`
    /// - Returns: `[Date]`
    func getIntervals(fromStart start: Date, toEnd end: Date, component: Calendar.Component, value: Int) -> [Date] {
        var result = [Date]()
        var working = start
        repeat {
            result.append(working)
            guard let new = Calendar.current.date(byAdding: component, value: value, to: working) else { return result }
            working = new
        } while working <= end
        return result
    }

    /// Calculate the total energy burned per minute, based on the following calcul (MET x 3.5 x Bodyweight(kg)) / 200
    private func calculateActivityEnergyBurnedPerMinute() {
            if let bodyMassQuantityType = HKQuantityType.quantityType(forIdentifier: .bodyMass) {
                query = HKSampleQuery(
                    sampleType: bodyMassQuantityType,
                    predicate: nil,
                    limit: 0,
                    sortDescriptors: nil,
                    resultsHandler: { _, samples, _ in
                        if let userWeightSample = samples?.last as? HKQuantitySample {
                            let weight = userWeightSample.quantity.doubleValue(for: .gramUnit(with: .kilo))
                            self.energyBurnedPerMinutes = (weight * 3.5 * self.workout.type.MET) / 200
                        } else {
                            self.setEnergyBurnedPerMinuteWithDefaultWeight()
                        }
                    })

                if let query {
                    healthStoreManager.store?.execute(query)
                } else {
                    setEnergyBurnedPerMinuteWithDefaultWeight()
                }
            } else {
                setEnergyBurnedPerMinuteWithDefaultWeight()
            }
    }

    /// Set the default energy burned per minute
    private func setEnergyBurnedPerMinuteWithDefaultWeight() {
        energyBurnedPerMinutes = (ProfileConfigurationViewModel.DEFAULT_USER_WEIGHT * 3.5 * workout.type.MET) / 200
    }
}
