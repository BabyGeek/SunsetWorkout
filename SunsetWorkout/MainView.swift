//
//  MainView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/09/2022.
//

import SwiftUI

struct MainView: View, KeyboardReadable {
    @AppStorage("currentPage", store: UserDefaults(suiteName: "defaults.com.poggero.SunsetWorkout")) var currenPage = 1
    @State private var isKeyboardVisible = false
    
    @StateObject var navigatorCoordinator: NavigationCoordinator = .shared

    var body: some View {
        if currenPage <= WalkthroughConfigurationSettings.totalPages {
            ConfigurationWalkthroughView(SWHealthStoreManager: SWHealthStoreManager())
                .preferredColorScheme(.dark)
                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                    isKeyboardVisible = newIsKeyboardVisible
                }
        } else {
            TabBarContainerView {
                switch navigatorCoordinator.pageType {
                case .workoutDetail(let workout):
                    WorkoutView(workout: workout)
                        .tabBarItem(
                            tab: .activities)
                case .summaryDetail(let summary):
                    HistoryView(summary: summary)
                        .tabBarItem(
                            tab: .history)
                case .dashboard:
                    DashboardView()
                        .tabBarItem(tab: .dashboard)
                case .createWorkout:
                    CreateFormView()
                        .tabBarItem(
                            tab: .create)
                case .launchActivity:
                    LaunchNewWorkoutView()
                        .tabBarItem(
                            tab: .launch)
                case .runningActivity(let workout):
                    ActivityView(workout: workout)
                case .workoutList:
                    WorkoutsView()
                        .tabBarItem(
                            tab: .activities)
                case .summaryList:
                    HistoriesView()
                        .tabBarItem(
                            tab: .history)
                }
            }
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
