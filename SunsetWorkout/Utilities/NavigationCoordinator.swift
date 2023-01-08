//
//  NavigationCoordinator.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 26/12/2022.
//

import Foundation
import SwiftUI

class NavigationCoordinator: ObservableObject {
    @Published var pageType: PageType = .dashboard
    
    enum PageType {
        case dashboard, createWorkout, launchActivity, workoutList, summaryList
        case runningActivity(_ workout: SWWorkout)
        case workoutDetail(_ workout: SWWorkout)
        case summaryDetail(_ summary: SWActivitySummary)
    }
    
    func showWorkoutView(_ workout: SWWorkout) {
        pageType = .workoutDetail(workout)
    }
    
    func showSummaryView(_ summary: SWActivitySummary) {
        pageType = .summaryDetail(summary)
    }
    
    func selectionFromTabBarItem(_ selection: TabBarItem) {
            switch selection {
            case .dashboard:
                pageType = .dashboard
            case .launch:
                pageType = .launchActivity
            case .create:
                pageType = .createWorkout
            case .history:
                pageType = .summaryList
            case .activities:
                pageType = .workoutList
            default:
                pageType = .dashboard
            }
    }
}
