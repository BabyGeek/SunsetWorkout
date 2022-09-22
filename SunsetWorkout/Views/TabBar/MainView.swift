//
//  MainView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/09/2022.
//

import SwiftUI

struct MainView: View {
    @AppStorage("currentPage") var currenPage = 1
    @State private var selection: String = "dashboard"
    @State private var selectedTab: TabBarItem = .dashboard

    var body: some View {
        if currenPage <= WalkthroughConfigurationSettings.totalPages {
            ConfigurationWalkthroughView(SWHealthStoreManager: SWHealthStoreManager())
                .preferredColorScheme(.dark)
        } else {
            TabBarContainerView(selection: $selectedTab) {
                DashboardView()
                    .tabBarItem(tab: .dashboard, selection: $selectedTab)
                
                DashboardView()
                    .tabBarItem(tab: .add, selection: $selectedTab)
                
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
