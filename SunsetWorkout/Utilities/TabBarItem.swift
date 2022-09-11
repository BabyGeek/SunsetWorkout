//
//  TabBarItem.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

enum TabBarItem {
    case dashboard, statistics, add, workouts, profile

    var symbol: Image {
        switch self {
        case .dashboard:
            return Image(systemName: "house")
        case .statistics:
            return Image(systemName: "chart.pie")
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
        case .statistics:
            return "Stats"
        case .add:
            return ""
        case .workouts:
            return "Workouts"
        case .profile:
            return "Profile"
        }
    }
}
