//
//  AnalyticsManager.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 29/10/2022.
//

import FirebaseAnalytics

struct AnalyticsManager {

    static func logCreatingWorkout(type: SWWorkoutType?) {
        Analytics.logEvent("creating_workout", parameters: [
            AnalyticsParameterItemName: "Creating workout",
            AnalyticsParameterContentType: type?.rawValue ?? "type not found"
        ])
    }

    static func logCreatedWorkout(type: SWWorkoutType?) {
        Analytics.logEvent("created_workout", parameters: [
            AnalyticsParameterContentType: type?.rawValue ?? "type not found"
        ])
    }

    static func logUpdatingWorkout(type: SWWorkoutType?) {
        Analytics.logEvent("updating_workout", parameters: [
            AnalyticsParameterContentType: type?.rawValue ?? "type not found"
        ])
    }

    static func logUpdatedWorkout(type: SWWorkoutType?) {
        Analytics.logEvent("updated_workout", parameters: [
            AnalyticsParameterContentType: type?.rawValue ?? "type not found"
        ])
    }

    static func logAddExercise(type: SWWorkoutType?) {
        Analytics.logEvent("add_exercise", parameters: [
            AnalyticsParameterContentType: type?.rawValue ?? "type not found"
        ])
    }

    static func logRunActivity() {
        Analytics.logEvent("run_activity", parameters: nil)
    }
}
