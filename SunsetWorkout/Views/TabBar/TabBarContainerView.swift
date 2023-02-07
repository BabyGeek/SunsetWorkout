//
//  TabBarContainerView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/09/2022.
//

import SwiftUI

struct TabBarContainerView<Content: View>: View, KeyboardReadable {
    @State private var isKeyboardVisible = false
    @ObservedObject var navigationCoordinator: NavigationCoordinator = .shared
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationView {
            VStack {
                content
                
                TabBarView()
                    .ignoresSafeArea(.all)
            }
            .background(BackgroundView())
            .navigationTitle(navigationCoordinator.selectedTab.navigationTitle)
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
    static var previews: some View {
        TabBarContainerView {
            DashboardView()
        }
    }
}
#endif
