//
//  TabBarContainerView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

struct TabBarContainerView<Content: View>: View, KeyboardReadable {
    @State private var tabs: [TabBarItem] = [TabBarItem]()
    @State private var isKeyboardVisible = false
    @Binding var selection: TabBarItem

    let content: Content

    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }

    var body: some View {
            NavigationView {
                VStack {
                    ZStack {
                        content
                            .endTextEditing(including: isKeyboardVisible ? .all : .subviews)
                    }

                    if !isKeyboardVisible {
                        TabBarView(tabs: tabs, selection: $selection, localSelection: selection)
                    }
                }
                .background(BackgroundView())
                .navigationTitle(selection.navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationViewStyle(.stack)
            .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
                self.tabs = value
            }
        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
            isKeyboardVisible = newIsKeyboardVisible
        }
    }
}

#if DEBUG
struct TabBarContainerView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .dashboard,
        .add,
        .workouts
    ]

    static var previews: some View {
        TabBarContainerView(selection: .constant(tabs.first!)) {
            DashboardView()
        }
    }
}
#endif
