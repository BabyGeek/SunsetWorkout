//
//  ActivitySerieInputAlertView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/11/2022.
//

import SwiftUI

struct ActivitySerieInputAlertView: View {
    @State var text: String = ""
    var action: (String) -> Void

    init(_ action: @escaping (String) -> Void) {
        self.action = action
    }

    var body: some View {
        ZStack {
            CustomBlurView(effect: .prominent, onChange: { _ in })
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("exercise.serie.input.title")

                Text("exercise.serie.goal")

                FloatingTextField(placeHolder: "exercise.serie.goal", text: $text, bgColor: .clear)
                    .keyboardType(.numberPad)

                Button {
                    action(text)
                } label: {
                    Text("button.save")
                        .foregroundColor(Color(.label))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(Capsule().stroke(Color.green))
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ActivitySerieInputAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySerieInputAlertView { text in
            print(text)
        }
    }
}
