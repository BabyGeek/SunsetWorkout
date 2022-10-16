//
//  TabBarItem.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

enum TabBarItem {
    case dashboard, launch, create, add, workouts

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
        }
    }

    var title: String {
        switch self {
        case .dashboard:
            return NSLocalizedString("dashboard.tab.title", comment: "Dashboard tab bar title")
        case .launch:
            return NSLocalizedString("launch.tab.title", comment: "Launch tab bar title")
        case .create:
            return NSLocalizedString("create.tab.title", comment: "Create tab bar title")
        case .add:
            return NSLocalizedString("add.tab.title", comment: "Add tab bar title")
        case .workouts:
            return NSLocalizedString("workouts.tab.title", comment: "Workouts tab bar title")
//        case .dashboard:
//            return "Dashboard"
//        case .launch:
//            return "Launch"
//        case .create:
//            return "Create"
//        case .add:
//            return "New workout"
//        case .workouts:
//            return "Workouts"
        }
    }

    var navigationTitle: String {
        switch self {
        case .dashboard:
            return NSLocalizedString("dashboard.navigation.title", comment: "Dashboard navigation title")
        case .launch:
            return ""
        case .create:
            return ""
        case .add:
            return ""
        case .workouts:
            return NSLocalizedString("workouts.navigation.title", comment: "Workouts navigation title")
        }
    }
}
