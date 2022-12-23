//
//  ViewModifiers.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 26/11/2022.
//

import SwiftUI


/// Modifier for hidding the scroll content background with iOS 16 if available
struct ClearListBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

/// View used with the .tabBarItem modifier
struct TabBarItemModifier: ViewModifier {
    let tab: TabBarItem
    @Binding var selection: TabBarItem

    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}


/// Toaster view modifier to display with a Bindable Bool
struct TasterPresentedModifier: ViewModifier {
    @Binding var isPresented: Bool
    let duration: TimeInterval
    let type: ToasterType
    let position: ToasterPosition
    let title: String
    let text: String

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                ToasterView(type: type, position: position, title: title, text: text, isPresented: $isPresented)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation(.easeInOut(duration: 1)) {
                                isPresented = false
                            }
                        }
                    }
            }
        }
    }
}

/// Toaster view modifier to display with a Bindable Identifiable and Equatable
struct TasterItemModifier<I: Identifiable & Equatable>: ViewModifier {
    @Binding var item: I?
    let duration: TimeInterval
    let type: ToasterType
    let position: ToasterPosition
    let title: String
    let text: String

    func body(content: Content) -> some View {
        ZStack {
            content
            if item != nil {
                ToasterView(type: type, position: position, title: title, text: text, isPresented: .constant(item != nil))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation(.easeInOut(duration: 1))  {
                                item = nil
                            }
                        }
                    }
            }
        }
    }
}
