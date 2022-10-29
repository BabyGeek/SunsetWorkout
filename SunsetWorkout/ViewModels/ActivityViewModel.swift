//
//  ActivityViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 27/10/2022.
//

import SwiftUI

class ActivityViewModel: ObservableObject {
    @Published var activity: SWActivity

    @Published var timePassed: Float = 0
    @Published var timePassedPercentage: Float = 0
    @Published var timeRemaining: Float = 0

    init(workout: SWWorkout) {
        self.activity = SWActivity(workout: workout, type: .initialized)
        AnalyticsManager.logInitializeActivity()
    }

    func run() {
        activity.run()
        AnalyticsManager.logRunActivity()
    }

    func pause() {
        activity.pause()
        AnalyticsManager.logPausedActivity()
    }

    func launchBreak(reset: Bool = false) {
        if activity.type != .paused || reset {
            timePassed = 0
            timePassedPercentage = 0
            timeRemaining = 35
        }

        if reset {
            pause()
        } else {
            activity.type = .inBreak
        }
    }

    func updateTimer() {
        if timeRemaining > 0  && activity.type == .inBreak {
            timeRemaining -= 1
            timePassed += 1

            timePassedPercentage = timePassed / 35
        }
    }
}
