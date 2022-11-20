//
//  TabBarItem.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

enum TabBarItem {
    case dashboard, launch, create, add, workouts, history, activities

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
        case .history:
            return Image(systemName: "calendar.badge.clock")
        case .activities:
            if #available(iOS 16, *) {
                return Image(systemName: "figure.strengthtraining.traditional")
            } else {
                return Image(systemName: "bolt.heart")
            }
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
        case .history:
            return NSLocalizedString("history.tab.title", comment: "Summaries tab bar title")
        case .activities:
            return NSLocalizedString("activities.tab.title", comment: "Summaries tab bar title")
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
            return ""
        case .history:
            return NSLocalizedString("history.navigation.title", comment: "Summaries navigation title")
        case .activities:
            return NSLocalizedString("activities.navigation.title", comment: "Summaries navigation title")
        }
    }
}
