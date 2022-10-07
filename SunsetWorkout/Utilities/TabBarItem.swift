//
//  TabBarItem.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

enum TabBarItem {
    case dashboard, launch, create, add, workouts, profile

    var symbol: Image {
        switch self {
        case .dashboard:
            return Image(systemName: "house")
        case .launch:
            return Image(systemName: "play")
        case .create:
            return Image(systemName: "plus")
        case .add:
            return Image(systemName: "plus")
        case .workouts:
            return Image(systemName: "bolt.heart")
        case .profile:
            return Image(systemName: "person")
        }
    }

    var title: String {
        switch self {
        case .dashboard:
            return "Dashboard"
        case .launch:
            return "Launch"
        case .create:
            return "Create"
        case .add:
            return "New workout"
        case .workouts:
            return "Workouts"
        case .profile:
            return "Profile"
        }
    }
}
