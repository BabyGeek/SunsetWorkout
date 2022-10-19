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
        GeometryReader { geometry in
            NavigationView {
                ZStack(alignment: .bottom) {
                    BackgroundView()

                    content
                        .padding(.bottom, isKeyboardVisible ? 0 : geometry.size.height/8)
                        .endTextEditing(including: isKeyboardVisible ? .all : .subviews)

                    if !isKeyboardVisible {
                        Spacer()
                        TabBarView(tabs: tabs, selection: $selection, localSelection: selection)
                            .frame(width: geometry.size.width, height: geometry.size.height/8)
                    }
                }
                .navigationBarItems(trailing: Button(
                    action: {
                        print("profile tapped")
                    }, label: {
                        ProfileButtonView()
                    })
                )
                .navigationTitle(selection.navigationTitle)
            }
            .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
                self.tabs = value
            }
        }
        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
            isKeyboardVisible = newIsKeyboardVisible
        }
    }
}

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
