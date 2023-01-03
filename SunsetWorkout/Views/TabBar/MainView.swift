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

    var body: some View {
        if currenPage <= WalkthroughConfigurationSettings.totalPages {
            ConfigurationWalkthroughView(SWHealthStoreManager: SWHealthStoreManager())
                .preferredColorScheme(.dark)
                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                    isKeyboardVisible = newIsKeyboardVisible
                }

        } else {
            TabBarContainerView(selection: $selectedTab) {
                DashboardView()
                    .tabBarItem(tab: .dashboard, selection: $selectedTab)
                
                CreateFormView()
                    .tabBarItem(tab: .create, selection: $selectedTab)

                LaunchNewWorkoutView()
                    .tabBarItem(tab: .launch, selection: $selectedTab)

                WorkoutsView()
                    .tabBarItem(tab: .activities, selection: $selectedTab)

                HistoriesView()
                    .tabBarItem(tab: .history, selection: $selectedTab)
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
