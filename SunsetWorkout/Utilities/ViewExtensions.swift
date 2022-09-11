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
