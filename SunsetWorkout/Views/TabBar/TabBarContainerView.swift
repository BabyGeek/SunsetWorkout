//
//  TabBarContainerView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

struct TabBarContainerView<Content: View>: View, KeyboardReadable {
    @State private var isKeyboardVisible = false
    
    @Binding var selection: TabBarItem
    var tabs: [TabBarItem]
    
    let content: Content

    init(tabs: [TabBarItem], selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
        self.tabs = tabs
    }

    var body: some View {
        NavigationView {
            VStack {
                content
                
                TabBarView(tabs: tabs, promotedItems: [.launch], selection: $selection)
                    .ignoresSafeArea(.all)
            }
            .background(BackgroundView())
            .navigationTitle(selection.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
            isKeyboardVisible = newIsKeyboardVisible
        }
    }
}

#if DEBUG
struct TabBarContainerView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .dashboard,
        .create,
        .launch,
        .workouts,
        .history
    ]

    static var previews: some View {
        TabBarContainerView(tabs: tabs, selection: .constant(tabs.first!)) {
            DashboardView()
        }
    }
}
#endif
