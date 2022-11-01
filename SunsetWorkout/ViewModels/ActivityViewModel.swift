//
//  ActivityViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 27/10/2022.
//

import Combine
import SwiftUI

class ActivityViewModel: ObservableObject {
    private var timer: Timer?

    @Published var activity: SWActivity {
        willSet {
            dump("did set activity")
        }
    }

    @Published var timePassed: Float = 0
    @Published var timePassedPercentage: Float = 0
    @Published var timeRemaining: Float = 0

    var shouldShowTimer: Bool {
        activity.shouldHaveTimer()
    }

    init(workout: SWWorkout) {
        self.activity = SWActivity(workout: workout, state: .initialized)
        AnalyticsManager.logInitializeActivity()
    }

    func launchTimer() {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                self.updateTimer()
            })
    }

    func stopTimer() {
            self.timer = nil
    }

    func pause() {
        activity.pause()
    }

    func play() {
        activity.run()
    }

    func cancel() {
        activity.state = .canceled
    }

    func activityStateIs(_ state: SWActivityState) -> Bool {
        activity.state == state
    }

    func isFinished() -> Bool {
        dump("finished: \(activityStateIs(.finished) || activityStateIs(.canceled))")
        dump("finished state: \(activity.state)")
        return activityStateIs(.finished) || activityStateIs(.canceled)
    }

    func canAskForPause() -> Bool {
        activityStateIs(.running) || activityStateIs(.inBreak)
    }

    func canAskForReplay() -> Bool {
        activityStateIs(.paused)
    }

    func getNext() {
        activity.getNext()
    }

    func setupTimer() {
        if activityStateIs(.finished) || activityStateIs(.canceled) {
            return
        } else if activityStateIs(.starting) {
            resetTimerWithRemaining(SWActivity.START_TIMER_DURATION)
        } else if activityStateIs(.inBreak) {
            if activity.exerciseHasChanged {
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

    func resetTimerWithRemaining(_ remaining: Float) {
        timePassed = 0
        timePassedPercentage = 0
        timeRemaining = remaining
    }

    func updateTimer() {
        if timeRemaining > 0 && shouldShowTimer {
            timeRemaining -= 1
            timePassed += 1
            updateTimePassedPercentage()
        } else if activityStateIs(.starting) || activityStateIs(.inBreak) {
            play()

            if shouldShowTimer {
                setupTimer()
            }
        } else if !activityStateIs(.initialized) {
            getNext()

            if activity.shouldSetUpTimer {
                setupTimer()
            }
        }

    }

    func updateTimePassedPercentage() {
        if activityStateIs(.starting) {
            timePassedPercentage = timePassed / SWActivity.START_TIMER_DURATION
        } else if activityStateIs(.inBreak) {
            if activity.exerciseHasChanged {
                timePassedPercentage = timePassed / activity.currentExerciseEndBreak
            } else {
                timePassedPercentage = timePassed / activity.currentExerciseBreak
            }
        } else {
            if activity.workout.type == .highIntensityIntervalTraining {
                timePassedPercentage = timePassed / activity.goal
            } else if activity.workout.type == .traditionalStrengthTraining {
                timePassedPercentage = 0
            }
        }
    }

    func getCurrentRepetitionLocalizedString() -> String {
        return String(format: NSLocalizedString("activity.exercise.repetition", comment: "Repetitions"),
                      getCurrentRepetitionString(),
                      getCurentRepetition(),
                      getTotalRepetition())
    }

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

    private func getNextExerciseString() -> String {
        activity.currentExercise?.name ?? NSLocalizedString("not.found", comment: "Not found label")
    }

    private func getCurrentRepetitionString() -> String {
        switch activity.workout.type {
        case .highIntensityIntervalTraining:
            return NSLocalizedString("workout.hiit.repetition", comment: "Workout HIIT repetition name")
        case .traditionalStrengthTraining:
            return NSLocalizedString("workout.stregth.repetition", comment: "Workout Strength repetition name")
        }
    }

    private func getCurentRepetition() -> Int {
        return activity.currentExerciseRepetition
    }

    private func getTotalRepetition() -> Int {
        return activity.totalExerciseRepetition
    }
}
