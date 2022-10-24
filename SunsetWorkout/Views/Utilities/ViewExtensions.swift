//
//  ViewExtensions.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 10/09/2022.
//

import Combine
import SwiftUI
import UIKit

// MARK: - TabBar
extension View {
    /// .tabBarItem modifier for View objects,
    /// allows you to register the tab and selection corresponding to the View attached
    /// - Parameters:
    ///   - tab: tab corresponding to the tab bar item
    ///   - selection: current tab selected
    /// - Returns: View modifier TabBarItemViewModifier
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}

// MARK: - View extension - detect and send action when click on the screen depending on priority included
extension View {
    /// Add extention to dismiss keyboard display on view click
    func endTextEditing(including: GestureMask = .all) -> some View {
        return self
            .highPriorityGesture(TapGesture().onEnded({ _ in
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                    to: nil, from: nil, for: nil)
            }), including: including)
    }
}

// MARK: - Keyboard Readable

/// Publisher to read keyboard changes.
protocol KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> { get }
}

extension KeyboardReadable {
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .map { _ in true },

            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }
}

// MARK: - View builders

extension View {
    /// ViewBuilder designed for conditional modifiers
    /// - Parameters:
    ///   - condition: condition to check to add the modifier
    ///   - transform: the transformation to apply on the view
    /// - Returns: the view modified if condition is set to true, else the view itself
    @ViewBuilder
    func conditional<Content: View>(_ condition: Bool, _ transform: @escaping (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension View {
    func asImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
