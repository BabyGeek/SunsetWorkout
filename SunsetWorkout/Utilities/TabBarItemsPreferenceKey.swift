//
//  TabBarItemsPreferenceKey.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

/// Tab Bar preference key to allow to handle the tabs selections
struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = [TabBarItem]()

    /// Allow to add multiple values to the tab bar
    /// - Parameters:
    ///   - value: current value
    ///   - nextValue: next value
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

/// View used with the .tabBarItem modifier
struct TabBarItemViewModifier: ViewModifier {
    let tab: TabBarItem
    @Binding var selection: TabBarItem

    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}
