//
//  TabBarContainerView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

struct TabBarContainerView<Content: View>: View {
    @State private var tabs: [TabBarItem] = [TabBarItem]()
    @Binding var selection: TabBarItem

    let content: Content

    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                content
                    .padding(.bottom, geometry.size.height/8)

                TabBarView(tabs: tabs, selection: $selection, localSelection: selection)
                     .frame(width: geometry.size.width)
             }
            .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
                self.tabs = value
            }
         }
    }
}

struct TabBarContainerView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
            .dashboard,
            .statistics,
            .add,
            .workouts,
            .profile
    ]

    static var previews: some View {
        TabBarContainerView(selection: .constant(tabs.first!)) {
            DashboardView()
        }
    }
}
