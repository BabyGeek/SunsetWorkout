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
    @State var selectingAdd: Bool = false

    var body: some View {
        tabBar
            .onChange(of: selection) { newValue in
                withAnimation(.interpolatingSpring(stiffness: 300, damping: 15)) {
                    localSelection = newValue
                }
            }
    }
}

#if DEBUG
struct TabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .dashboard,
        .add,
        .workouts
    ]

    static var previews: some View {
        VStack {
            Spacer()
            TabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
                .preferredColorScheme(.dark)
        }
    }
}
#endif

extension TabBarView {
    /// Tab bar item view
    /// - Parameter item: item of the tab bar presented
    /// - Returns: some View representing the tab item
    private func tabView(item: TabBarItem, forceShowText: Bool = false) -> some View {
        VStack {
            item.symbol

            if (localSelection == item || forceShowText) ||
                ((localSelection == .create || localSelection == .launch) &&
                 item == .add) {
                Text(item.title)
                    .font(.caption)
            }
        }
    }

    /// Tab bar display, go through each item and display a tabView and add tap gesture
    private var tabBar: some View {
        VStack {
            if self.selectingAdd {
                HStack {
                    Spacer()
                    tabView(item: TabBarItem.launch, forceShowText: true)
                        .onTapGesture {
                            switchToTab(tab: TabBarItem.launch)
                        }
                    Spacer()
                    tabView(item: TabBarItem.create, forceShowText: true)
                        .onTapGesture {
                            switchToTab(tab: TabBarItem.create)
                        }
                    Spacer()
                }
            }
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    if tab != .create && tab != .launch {
                        Spacer()
                        tabView(item: tab)
                            .onTapGesture {
                                switchToTab(tab: tab)
                            }
                        Spacer()
                    }
                }
            }
        }
    }

    /// Allow swicthing between each tabs
    /// - Parameter tab: the tab to switch to
    private func switchToTab(tab: TabBarItem) {
        selection = tab

        if tab == .add {
            self.selectingAdd = true
        } else {
            self.selectingAdd = false
        }
    }
}
