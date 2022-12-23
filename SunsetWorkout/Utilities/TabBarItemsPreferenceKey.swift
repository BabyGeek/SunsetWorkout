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
