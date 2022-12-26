//
//  NavigationCoordinator.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 26/12/2022.
//

import Foundation

class NavigationCoordinator: ObservableObject {
    var workoutToShow: SWWorkout?
    var shouldShowWorkoutView: Bool = false
    
    func showWorkoutView(_ workout: SWWorkout) {
        workoutToShow = workout
        shouldShowWorkoutView = true
    }
}
