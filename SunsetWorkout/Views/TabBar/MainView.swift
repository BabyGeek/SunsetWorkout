//
//  MainView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/09/2022.
//

import SwiftUI

struct MainView: View {
    @State private var selection: String = "dashboard"
    @State private var selectedTab: TabBarItem = .dashboard
    @State private var boardingDone: Bool = false

    var body: some View {
        if boardingDone {
            TabBarContainerView(selection: $selectedTab) {
                DashboardView()
                    .tabBarItem(tab: .dashboard, selection: $selectedTab)

                FeelingConfigurationView()
                    .tabBarItem(tab: .statistics, selection: $selectedTab)

                AuthorizationView()
                        .tabBarItem(tab: .add, selection: $selectedTab)

                AuthorizationView()
                        .tabBarItem(tab: .workouts, selection: $selectedTab)

                ProfileConfigurationView()
                    .tabBarItem(tab: .profile, selection: $selectedTab)
            }
        } else {
            AuthorizationView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
