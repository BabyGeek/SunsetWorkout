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
    func tabBarItem(tab: TabBarItem) -> some View {
        modifier(TabBarItemModifier(tab: tab))
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
    /// Add a view transformation depending on a condition.
    ///
    /// Use this method to use a conditionnal view modifier or transformation.
    /// "Blur-Conditional" button:
    ///
    ///     struct ShowLicenseAgreement: View {
    ///         @State private var isBlur: Bool = false
    ///
    ///         var body: some View {
    ///             Button(action: {
    ///                 isBlur = true
    ///             }) {
    ///                 Text("Blur this button")
    ///             }
    ///             .conditional(isBlur) { button in
    ///                 button
    ///                     .blur(radius: 20)
    ///             }
    ///         }
    ///     }
    ///
    /// ![A toast view that shows a message.](SwiftUI-ToastViewItemContent.png)
    /// - Parameters:
    ///   - condition: condition to check to add the modifier
    ///   - transform: the transformation to apply on the view
    @ViewBuilder
    func conditional<Content: View>(_ condition: Bool, _ transform: @escaping (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    
    /// Presents a toast view for a given error.
    ///
    /// Use this method to display a toast view that show an
    /// `SWError` message on the top position of the view for 5 seconds.
    /// "Present Toast-Error Cover" button:
    ///
    ///     struct ShowLicenseAgreement: View {
    ///         @State private var error: SWError?
    ///
    ///         var body: some View {
    ///             Button(action: {
    ///                 error = SWError(error: RealmError.failure)
    ///             }) {
    ///                 Text("Show an error toast")
    ///             }
    ///             .toastWithError($error)
    ///         }
    ///     }
    ///
    /// ![A toast view that shows a message.](SwiftUI-ToastViewItemContent.png)
    ///
    /// - Parameters :
    ///   - error: A binding to an `Optional SWError` value that determines whether to present the sheet that you create in the modifier’s content closure.
    ///   - position:  A `ToasterPosition` value that determines the position of the toast, default top
    ///   - duration: A `TimeInterval` value that determines the time that the error is displayed on the screen, default is 5 seconds
    @ViewBuilder
    func toastWithError(
        _ error: Binding<SWError?>,
        position: ToasterPosition = .top,
        duration: TimeInterval = 5) -> some View {
        self
            .toast(
                item: error,
                type: .error,
                position: position,
                title: error.wrappedValue?.title ?? "",
                text: error.wrappedValue?.description ?? "",
                duration: duration
            )
    }
}

// MARK: - Toaster methods to call modifiers
extension View {
    /// Presents a toast view that show on the edge given
    /// using the binding you provide to display.
    ///
    /// Use this method to display a toast view that show a
    /// success message on the top position of the view for 5 seconds.
    /// "Present Toast-Screen Cover" button:
    ///
    ///     struct ShowLicenseAgreement: View {
    ///         @State private var isShowingSheet = false
    ///
    ///         var body: some View {
    ///             Button(action: {
    ///                 isShowingSheet.toggle()
    ///             }) {
    ///                 Text("Show License Agreement Success")
    ///             }
    ///             .toast(
    ///             isPresented: $isShowingToast,
    ///             title: "Success License Agreement",
    ///             text: "You successfully get your license agreement")
    ///         }
    ///     }
    ///
    /// ![A toast view that shows a message.](SwiftUI-ToastViewItemContent.png)
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the sheet that you create in the modifier’s content closure.
    ///   - type: An enum type that determines the toaster type
    ///   - position: An enum position that determines the position of the toast
    ///   - title: A String that determines the title of the toast
    ///   - text: A String text that determines the text of the toast
    ///   - duration: A TimeInterval that determines how long the toast will appear on the screen
    func toast(
        isPresented: Binding<Bool>,
        type: ToasterType = .success,
        position: ToasterPosition = .top,
        title: String = "",
        text: String = "",
        duration: TimeInterval = 5) -> some View {
            modifier(
                TasterPresentedModifier(
                    isPresented: isPresented,
                    duration: duration,
                    type: type,
                    position: position,
                    title: title,
                    text: text))
        }
    
    /// Presents a toast view that show on the edge given
    /// using the binding you provide to display.
    ///
    /// Use this method to display a toast view that show a
    /// success message on the top position of the view for 5 seconds.
    /// "Present Toast-Screen Cover" button:
    ///
    ///     struct TestToastItem: Identifiable, Equatable {
    ///         let id = UUID()
    ///
    ///         static func == (lhs: TestToastItem, rhs: TestToastItem) -> Bool {
    ///             lhs.id == rhs.id
    ///         }
    ///     }
    ///
    ///     struct ShowLicenseAgreement: View {
    ///         @State private var item: TestToastItem?
    ///
    ///         var body: some View {
    ///             Button(action: {
    ///                 item = TestToastItem()
    ///             }) {
    ///                 Text("Show License Agreement Success")
    ///             }
    ///             .toast(
    ///             item: $item,
    ///             title: "Success License Agreement",
    ///             text: "You successfully get your license agreement")
    ///         }
    ///     }
    ///
    /// ![A toast view that shows a message.](SwiftUI-ToastViewItemContent.png)
    ///
    /// - Parameters:
    ///   - item: A binding to an Identifiable and Equatable value that determines whether to present the sheet that you create in the modifier’s content closure.
    ///   - type: An enum type that determines the toaster type
    ///   - position: An enum position that determines the position of the toast
    ///   - title: A String that determines the title of the toast
    ///   - text: A String text that determines the text of the toast
    ///   - duration: A TimeInterval that determines how long the toast will appear on the screen
    func toast<I: Identifiable & Equatable>(
        item: Binding<I?>,
        type: ToasterType = .success,
        position: ToasterPosition = .top,
        title: String = "",
        text: String = "",
        duration: TimeInterval = 5) -> some View {
            modifier(
                TasterItemModifier(
                    item: item,
                    duration: duration,
                    type: type,
                    position: position,
                    title: title,
                    text: text))
        }
}

extension View {
    func clearListBackground() -> some View {
        modifier(ClearListBackgroundModifier())
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func numbersOnly(_ text: Binding<String>, hasDecimal: Bool = false) -> some View {
        self
            .modifier(NumbersOnlyViewModifier(text: text, hasDecimal: hasDecimal))
    }
}
