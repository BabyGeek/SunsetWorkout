//
//  ActivityViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 27/10/2022.
//

import Combine
import HealthKit
import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var error: SWError?
    @Published var activity: SWActivity
    @Published var timePassed: Float = 0
    @Published var timePassedPercentage: Float = 0
    @Published var timeRemaining: Float = 0
    @Published var presentSerieAlert: Bool  = false
    @Published var saved: Bool = false
    @Published var activitySummary: SWActivitySummary?

    private var inputPrepared: [String: Any] = [:]
    private var excisesRepetitionsSaved: [String: [Int]] = [:]
    private var query: HKQuery?

    let realmManager = RealmManager()
    let healthStoreManager = SWHealthStoreManager()

    var cancellable: AnyCancellable?

    var shouldShowTimer: Bool {
        activity.shouldHaveTimer() ||
        (activityStateIs(.paused) &&
         (activityLastStateIs(.inBreak) || activity.workout.type == .highIntensityIntervalTraining))
    }

    var exerciseHasChanged: Bool {
        withAnimation {
            activity.exerciseHasChanged
        }
    }

    var canSkip: Bool {
        withAnimation {
            activityStateIs(.running) || activityStateIs(.inBreak)
        }
    }

    var waitForInput: Bool {
        withAnimation {
            !shouldShowTimer && activity.isWaitingForInput()
        }
    }

    var canAskForPause: Bool {
        withAnimation {
            activityStateIs(.running) || activityStateIs(.inBreak)
        }
    }

    var canAskForReplay: Bool {
        withAnimation {
            activityStateIs(.paused)
        }
    }

    var isFinished: Bool {
        withAnimation {
            activityStateIs(.finished) || activityStateIs(.canceled)
        }
    }

    var canStart: Bool {
        withAnimation {
            !activity.workout.exercises.isEmpty
        }
    }

    init(workout: SWWorkout) {
        self.activity = SWActivity(workout: workout, state: .initialized)
        AnalyticsManager.logInitializeActivity()

        cancellable = activity.objectWillChange.sink { [weak self] _ in
            if let self {
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }
        }
    }

    /// Save the workout session
    @MainActor func save() {
        if !activityStateIs(.initialized) && !activityStateIs(.starting) && !saved && isFinished {
            do {
                self.activitySummary = self.activity.getSummary()
                try self.save(with: SWActivitySummaryEntity.init)
            } catch {
                self.error = SWError(error: error)
            }
        }
    }

    func skip() {
        prepareAddInput()
        inputPrepared["skipped"] = true

        if activity.workout.type == .traditionalStrengthTraining {
            timeRemaining = 0
            saveInputSerie("0")
            getNext()
            setupTimer()
        } else if activity.workout.type == .highIntensityIntervalTraining {
            saveInputRound()
            timeRemaining = 0
        }
    }

    func pause() {
        if !isFinished {
            activity.pause()
        }
    }

    func play() {
        if !isFinished {
            activity.run()
        }
    }

    func cancel() {
        activity.endActivity(canceled: true)
    }

    func activityStateIs(_ state: SWActivityState) -> Bool {
        activity.state == state
    }

    func activityLastStateIs(_ state: SWActivityState) -> Bool {
        activity.lastState == state
    }

    func getNext() {
        activity.getNext()
    }

    /// Setup the timer depending on workout type and activity state
    func setupTimer() {
        if activityStateIs(.finished) || activityStateIs(.canceled) || activityStateIs(.paused) {
            return
        } else if activityStateIs(.starting) {
            resetTimerWithRemaining(SWActivity.START_TIMER_DURATION)
        } else if activityStateIs(.inBreak) {
            if exerciseHasChanged {
                resetTimerWithRemaining(activity.currentExerciseEndBreak)
            } else {
                resetTimerWithRemaining(activity.currentExerciseBreak)
            }
        } else {
            if activity.workout.type == .highIntensityIntervalTraining {
                resetTimerWithRemaining(activity.goal)
            } else if activity.workout.type == .traditionalStrengthTraining {
                resetTimerWithRemaining(0)
            }
        }
    }

    /// Reset the timer an set the remaining time
    /// - Parameter remaining: `Float`
    func resetTimerWithRemaining(_ remaining: Float) {
        timePassed = 0
        timePassedPercentage = 0
        timeRemaining = remaining
    }

    /// Update the timer, if timer has ended setup the next step
    func updateTimer() {
        if timeRemaining > 0 && shouldShowTimer && !activityStateIs(.paused) {
            timeRemaining -= 1
            timePassed += 1
            updateTimePassedPercentage()
        } else {
            if activityStateIs(.starting) {
                play()
            } else if !activityStateIs(.initialized) {
                if activityStateIs(.inBreak) {
                    play()
                } else if !activityStateIs(.paused) {
                    if activity.workout.type == .highIntensityIntervalTraining {
                            prepareAddInput()
                            saveInputRound()
                    }

                    if activity.workout.type != .traditionalStrengthTraining {
                        getNext()
                    }
                }
            }

            if shouldShowTimer {
                setupTimer()
            }
        }
    }

    /// Save an input for a Strength serie
    /// - Parameter input: `String`
    func saveInputSerie(_ input: String) {
        if activity.workout.type == .highIntensityIntervalTraining {
            return
        }

        inputPrepared["value"] = input
        addInput()
    }

    /// Save an input of the time passed for HIIT round
    func saveInputRound() {
        if activity.workout.type == .traditionalStrengthTraining {
            return
        }

        inputPrepared["value"] = timePassed
        addInput()
    }

    /// Add the prepared input to the activity
    func addInput() {
        guard let currenExerciseID = activity.currentExercise?.id else { return }

        if excisesRepetitionsSaved[currenExerciseID] != nil {
            if excisesRepetitionsSaved[currenExerciseID]!.contains(activity.currentExerciseRepetition) { return }
            excisesRepetitionsSaved[currenExerciseID]!.append(activity.currentExerciseRepetition)
        } else {
            excisesRepetitionsSaved[currenExerciseID] = [activity.currentExerciseRepetition]
        }

        activity.addInput(inputPrepared)
    }

    /// Prepare the next input with current exercise ID and current repetition number
    func prepareAddInput() {
        guard let currenExerciseID = activity.currentExercise?.id else { return }

        inputPrepared = [:]
        inputPrepared["exerciseID"] = currenExerciseID
        inputPrepared["currentRepetition"] = activity.currentExerciseRepetition
    }

    /// Update the timePassed value to the equivalent percentage depending on state and type
    func updateTimePassedPercentage() {
        if activityStateIs(.starting) {
            timePassedPercentage = timePassed / SWActivity.START_TIMER_DURATION
        } else if activityStateIs(.inBreak) {
            if exerciseHasChanged {
                timePassedPercentage = timePassed / activity.currentExerciseEndBreak
            } else {
                timePassedPercentage = timePassed / activity.currentExerciseBreak
            }
        } else {
            if activity.workout.type == .highIntensityIntervalTraining {
                timePassedPercentage = timePassed / activity.goal
            }
        }
    }

    func getCurrentExerciseName() -> String {
        activity.currentExercise?.name ?? NSLocalizedString("not.found", comment: "Not found")
    }

    /// Get the repetition text to display
    /// - Returns: `String`
    func getCurrentRepetitionLocalizedString() -> String {
        return String(format: NSLocalizedString("activity.exercise.repetition", comment: "Repetitions"),
                      getCurrentRepetitionString(),
                      getCurrentRepetition(),
                      getTotalRepetition())
    }

    /// Get the next exercise text to display
    /// - Returns: `String`
    func getNextExerciseLocalizedString() -> String {
        if activity.workout.getExerciseOrder(activity.nextExerciseOrder) == nil {
            return String(
                format: NSLocalizedString("activity.exercise.next.last", comment: "Next and last exercise label"),
                getNextExerciseString())
        }
        return String(
            format: NSLocalizedString("activity.exercise.next", comment: "Next exercise label"),
            getNextExerciseString())
    }

    /// Get next exercise name
    /// - Returns: `String`
    private func getNextExerciseString() -> String {
        activity.currentExercise?.name ?? NSLocalizedString("not.found", comment: "Not found label")
    }

    /// Get the current repetition string text, `round` for HIIT, `serie` for Strength
    /// - Returns: `String`
    private func getCurrentRepetitionString() -> String {
        switch activity.workout.type {
        case .highIntensityIntervalTraining:
            return NSLocalizedString("workout.hiit.repetition", comment: "Workout HIIT repetition name")
        case .traditionalStrengthTraining:
            return NSLocalizedString("workout.strength.repetition", comment: "Workout Strength repetition name")
        }
    }

    /// Get the current repetition number
    /// - Returns: `Int`
    private func getCurrentRepetition() -> Int {
        activity.currentExerciseRepetition
    }

    /// Get the total number of repetition for current exercise
    /// - Returns: `Int`
    private func getTotalRepetition() -> Int {
        activity.totalExerciseRepetition
    }
}

// MARK: - Realm and HealthKit save
extension ActivityViewModel {
    /// Save activitty to realm
    /// - Parameters:
    ///   - model: `SWActivitySummary`
    ///   - reverseTransformer: `(SWActivitySummary) -> SWActivitySummaryEntity`
    func save(with reverseTransformer: (SWActivitySummary) -> SWActivitySummaryEntity) throws {
        do {
            if let activitySummary {
                try realmManager.save(model: activitySummary, with: reverseTransformer)
                self.activitySummary = try? realmManager.fetch(with: SWActivitySummary.allByDateDESC).first
                saved = true
            }
        } catch {
            self.error = SWError(error: error)
        }
    }
}
