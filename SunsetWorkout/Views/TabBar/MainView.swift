//
//  MainView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/09/2022.
//

import SwiftUI

struct MainView: View, KeyboardReadable {
    @AppStorage("currentPage") var currenPage = 1
    @State private var selection: String = "dashboard"
    @State private var selectedTab: TabBarItem = .dashboard
    @State private var isKeyboardVisible = false

    var body: some View {
        if currenPage <= WalkthroughConfigurationSettings.totalPages {
            ConfigurationWalkthroughView(SWHealthStoreManager: SWHealthStoreManager())
                .preferredColorScheme(.dark)
                .endTextEditing(including: isKeyboardVisible ? .all : .subviews)
                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                    isKeyboardVisible = newIsKeyboardVisible
                }

        } else {
            TabBarContainerView(selection: $selectedTab) {
                    DashboardView()
                        .tabBarItem(tab: .dashboard, selection: $selectedTab)

                    EmptySelectingView()
                        .tabBarItem(tab: .add, selection: $selectedTab)

                    LaunchNewWorkoutView()
                        .tabBarItem(tab: .launch, selection: $selectedTab)

                    CreateFormView()
                        .tabBarItem(tab: .create, selection: $selectedTab)

                    DashboardView()
                        .tabBarItem(tab: .workouts, selection: $selectedTab)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
