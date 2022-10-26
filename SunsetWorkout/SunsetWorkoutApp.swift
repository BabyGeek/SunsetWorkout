//
//  SunsetWorkoutApp.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 24/08/2022.
//

import SwiftUI
import Firebase
import FirebaseAnalytics
import FirebaseCrashlytics
import FirebasePerformance

@main
struct SunsetWorkoutApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
