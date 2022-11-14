//
//  ToasterModifiers.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/11/2022.
//

import SwiftUI

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
                ToasterView(type: type, position: position, title: title, text: text)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                isPresented = false
                            }
                        }
                    }
            }
        }
    }
}

struct TasterItemModifier<I: Identifiable>: ViewModifier {
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
                ToasterView(type: type, position: position, title: title, text: text)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                            withAnimation {
                                item = nil
                            }
                        }
                    }
            }
        }
    }
}
