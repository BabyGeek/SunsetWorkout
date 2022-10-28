//
//  SWActivity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 27/10/2022.
//

import Foundation

class SWActivity {
    let workout: SWWorkout
    var type: SWActivityType
    var currentExercise: SWExercise?
    var startDate: Date?
    var endDate: Date?

    init(workout: SWWorkout,
         type: SWActivityType,
         currentExercise: SWExercise? = nil,
         startDate: Date? = nil,
         endDate: Date? = nil) {
        self.workout = workout
        self.type = type
        self.currentExercise = currentExercise
        self.startDate = startDate
        self.endDate = endDate
    }

    func next() {
        // TODO change current state / exercise
    }

    func inBreak() {
        self.type = .inBreak

        // TODO return break time
    }

    func pause() {
        self.type = .paused
    }

    func run() {
        self.type = .running
    }

    func cancel() {
        self.type = .cancelled
    }

    func endActivity() {
        if self.type != .cancelled {
            self.type = .finished
        }

        self.endDate = Date()
    }
}
