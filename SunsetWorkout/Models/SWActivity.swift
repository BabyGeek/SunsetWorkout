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

    // MARK: - Properties
    let cantStepOverState: [SWActivityState] = [.initialized, .starting, .paused, .canceled, .finished]
    let workout: SWWorkout
    var shouldSetUpTimer: Bool = false
    var startDate: Date = Date()
    var endDate: Date = Date()
    var events: [HKWorkoutEvent] = []
    var nextExerciseOrder: Int = 0
    var lastState: SWActivityState
    var workoutInputs: [String: [[String: Any]]] = [:]
    

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
    
    // MARK: - Computed properties
    var duration: Double {
        endDate.timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate
    }
    
    var totalEnergyBurned: Double {
        850
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
//        events.append(HKWorkoutEvent(
//            type: .pause,
//            dateInterval: DateInterval(start: startDate, end: Date()),
//            metadata: nil))
    }

    func run() {
        if state == .paused {
            state = lastState
//            events.append(HKWorkoutEvent(
//                type: .resume,
//                dateInterval: DateInterval(start: startDate, end: Date()),
//                metadata: nil))
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
    }

    func getNext() {
        shouldSetUpTimer = false

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

    func initFirstExercise() {
        exerciseHasChanged = true
        nextExerciseOrder = 2
        currentExerciseRepetition = 1
        currentExercise = workout.getFirstExercise()
        nextExercise = workout.getExerciseOrder(nextExerciseOrder)
        currentExerciseEndBreak = nextExerciseEndBreak
        start()
        startDate = Date()
    }

    func increaseExerciseRepetition() {
        shouldSetUpTimer = true
        exerciseHasChanged = false
        currentExerciseRepetition += 1
        inBreak()
    }

    func changeExercise() {
        shouldSetUpTimer = true
        exerciseHasChanged = true
        nextExerciseOrder += 1
        currentExerciseRepetition = 1
        currentExerciseEndBreak = nextExerciseEndBreak
        currentExercise = nextExercise
        nextExercise = workout.getExerciseOrder(nextExerciseOrder)
        inBreak()
    }

    func getMetadataForCurrentExercise() {
        currentExercise?.getMetadataFor(workout.type) { (exerciseEndBreak, exerciseBreak, exerciseRepetition, goal) in
            self.nextExerciseEndBreak = exerciseEndBreak ?? 0
            self.currentExerciseBreak = exerciseBreak ?? 0
            self.totalExerciseRepetition = exerciseRepetition ?? 0
            self.goal = goal ?? 0
        }
    }

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

    func isWaitingForInput() -> Bool {
        switch state {
        case .running:
            return workout.type == .traditionalStrengthTraining
        default:
            return false
        }
    }
    
    func addInput(_ inputPrepared: [String: Any]) {
        guard let exerciseID = inputPrepared["exerciseID"] as? String, exerciseID != "0" else { return }
        var inputMutable = inputPrepared
        inputMutable.removeValue(forKey: "exerciseID")
        
        if let _ = workoutInputs[exerciseID] {
            workoutInputs[exerciseID]!.append(inputMutable)
        } else {
            workoutInputs[exerciseID] = [inputMutable]
        }
    }
    
    func getSummary() -> SWActivitySummary {
        SWActivitySummary(
            workout: workout,
            type: workout.type,
            inputs: workoutInputs,
            startDate: startDate,
            endDate: endDate,
            duration: duration,
            totalEnergyBurned: totalEnergyBurned,
            events: events
        )
    }
}
