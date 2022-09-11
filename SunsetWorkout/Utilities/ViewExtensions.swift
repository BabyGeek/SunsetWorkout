//
//  ViewExtensions.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 10/09/2022.
//

import SwiftUI

// MARK: - TabBar
extension View {
    /// .tabBarItem modifier for View objects,
    /// allows you to register the tab and selection corresponding to the View attached
    /// - Parameters:
    ///   - tab: tab corresponding to the tab bar item
    ///   - selection: current tab selected
    /// - Returns: View modifier TabBarItemViewModifier
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}

// MARK: - Navigate
extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
