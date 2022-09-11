//
//  TabBarView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

struct TabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @State var localSelection: TabBarItem

    var body: some View {
        tabBar
            .onChange(of: selection) { newValue in
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 15)) {
                    localSelection = newValue
                }
            }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .dashboard,
        .statistics,
        .add,
        .workouts,
        .profile
    ]

    static var previews: some View {
        VStack {
            Spacer()
            TabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
        }
    }
}

extension TabBarView {
    /// Tab bar item view
    /// - Parameter item: item of the tab bar presented
    /// - Returns: some View representing the tab item
    private func tabView(item: TabBarItem) -> some View {
        VStack {
            item.symbol

            if localSelection == item {
                Text(item.title)
                    .font(.caption)
            }
        }
    }

    /// Tab bar display, go through each item and display a tabView and add tap gesture
    private var tabBar: some View {
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    Spacer()
                    tabView(item: tab)
                        .onTapGesture {
                            switchToTab(tab: tab)
                        }
                    Spacer()
                }
            }
        }

    /// Allow swicthing between each tabs
    /// - Parameter tab: the tab to switch to
    private func switchToTab(tab: TabBarItem) {
        selection = tab
    }
}
