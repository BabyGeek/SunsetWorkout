//
//  SWActivity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 27/10/2022.
//

import Foundation

class SWActivity {
    static let START_TIMER_DURATION: Float = 5
    let cantStepOverState: [SWActivityState] = [.initialized, .starting, .paused, .canceled, .finished]
    var exerciseHasChanged: Bool = false
    var shouldSetUpTimer: Bool = false
    let workout: SWWorkout
    var state: SWActivityState {
        willSet(newState) {
            if state != .finished && state != .canceled {
                self.state = newState
            }
        }
    }
    var startDate: Date?
    var endDate: Date?
    var pauses: [TimeInterval]?

    var currentExercise: SWExercise?
    var nextExercise: SWExercise?
    var nextExerciseOrder: Int = 0
    var currentExerciseRepetition: Int = 0
    var totalExerciseRepetition: Int = 0
    var currentExerciseEndBreak: Float = 0
    var nextExerciseEndBreak: Float = 0
    var currentExerciseBreak: Float = 0
    var goal: Float = 0

    init(workout: SWWorkout,
         state: SWActivityState) {
        self.workout = workout
        self.state = state
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
        state = .paused
    }

    func run() {
        state = .running
    }

    func cancel() {
        state = .canceled
        endActivity(canceled: true)
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

        DispatchQueue.main.async {
            if !canceled {
                self.finish()
            } else {
                self.cancel()
            }
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
}
