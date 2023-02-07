//
//  ViewModifiers.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 26/11/2022.
//

import Combine
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

    func body(content: Content) -> some View {
        content
            .opacity(NavigationCoordinator.shared.selectedTab == tab ? 1.0 : 0.0)
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


/// View modifier for numbers only view
struct NumbersOnlyViewModifier: ViewModifier {
    @Binding var text: String
    var hasDecimal: Bool
    
    func body(content: Content) -> some View {
        content
            .keyboardType(hasDecimal ? .decimalPad : .numberPad)
            .onReceive(Just(text)) { newValue in
                var numbers = "0123456789"
                let decimalSeparator: String = Locale.current.decimalSeparator ?? "."
                
                if hasDecimal {
                    numbers.append(decimalSeparator)
                }
                
                if newValue.components(separatedBy: decimalSeparator).count - 1 > 1 {
                    let filtered = newValue
                    self.text = String(filtered.dropLast())
                } else {
                    let filtered = newValue.filter { numbers.contains($0) }
                    if filtered != newValue {
                        self.text = filtered
                    }
                }
            }
    }
}
