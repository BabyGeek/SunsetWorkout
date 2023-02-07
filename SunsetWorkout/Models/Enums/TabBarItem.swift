//
//  TabBarItem.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

enum TabBarItem: CaseIterable {
    case dashboard, create, launch, history, activities
    
    var symbol: Image {
        switch self {
        case .dashboard:
            return Image(systemName: "house")
        case .create:
            return Image(systemName: "plus")
        case .launch:
            return Image(systemName: "play")
        case .history:
            return Image(systemName: "calendar.badge.clock")
        case .activities:
            if #available(iOS 16, *) {
                return Image(systemName: "figure.strengthtraining.traditional")
            } else {
                return Image(systemName: "bolt")
            }
        }
    }

    var navigationTitle: String {
        switch self {
        case .dashboard:
            return NSLocalizedString("dashboard.navigation.title", comment: "Dashboard navigation title")
        case .launch:
            return NSLocalizedString("launch.navigation.title", comment: "Dashboard navigation title")
        case .create:
            return NSLocalizedString("create.navigation.title", comment: "Dashboard navigation title")
        case .history:
            return NSLocalizedString("history.navigation.title", comment: "Summaries navigation title")
        case .activities:
            return NSLocalizedString("activities.navigation.title", comment: "Summaries navigation title")
        }
    }
    
    var isPromoted: Bool {
        switch self {
        case .launch:
            return true
        default:
            return false
        }
    }
}
