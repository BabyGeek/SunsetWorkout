//
//  MainView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/09/2022.
//

import SwiftUI

struct MainView: View, KeyboardReadable {
    @AppStorage("currentPage", store: UserDefaults(suiteName: "defaults.com.poggero.SunsetWorkout")) var currenPage = 1
    @State private var selection: String = "dashboard"
    @State private var selectedTab: TabBarItem = .dashboard
    @State private var isKeyboardVisible = false
    
    @StateObject var navigatorCoordinator: NavigationCoordinator = .init()

    var body: some View {
        if currenPage <= WalkthroughConfigurationSettings.totalPages {
            ConfigurationWalkthroughView(SWHealthStoreManager: SWHealthStoreManager())
                .preferredColorScheme(.dark)
                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                    isKeyboardVisible = newIsKeyboardVisible
                }
        } else {
            TabBarContainerView(
                tabs: [
                        .dashboard,
                        .create,
                        .launch,
                        .activities,
                        .history
                ],
                selection: $selectedTab) {
                switch navigatorCoordinator.pageType {
                case .workoutDetail(let workout):
                    WorkoutView(workout: workout)
                        .tabBarItem(tab: .activities, selection: $selectedTab)
                case .summaryDetail(let summary):
                    HistoryView(summary: summary)
                        .tabBarItem(tab: .history, selection: $selectedTab)
                case .dashboard:
                    DashboardView()
                        .tabBarItem(tab: .dashboard, selection: $selectedTab)
                case .createWorkout:
                    CreateFormView()
                        .tabBarItem(tab: .create, selection: $selectedTab)
                case .launchActivity:
                    LaunchNewWorkoutView()
                        .tabBarItem(tab: .launch, selection: $selectedTab)
                case .runningActivity(let workout):
                    ActivityView(workout: workout)
                case .workoutList:
                    WorkoutsView()
                        .tabBarItem(tab: .activities, selection: $selectedTab)
                case .summaryList:
                    HistoriesView()
                        .tabBarItem(tab: .history, selection: $selectedTab)
                }
            }
            .environmentObject(navigatorCoordinator)
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
