//
//  ActivitySerieInputAlertView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/11/2022.
//

import SwiftUI

struct ActivitySerieInputAlertView: View {
    @State var text: String = ""
    var goal: String = ""
    var action: (String) -> Void

    init(goal: String, _ action: @escaping (String) -> Void) {
        self.goal = goal
        self.action = action
    }

    var body: some View {
        ZStack {
            CustomBlurView(effect: .prominent, onChange: { _ in })
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("exercise.serie.input.title")

                Text(String(
                    format: NSLocalizedString("exercise.serie.goal", comment: "Exercise goal"),
                    goal))

                FloatingTextField<EmptyView>(
                    placeHolder: "exercise.serie.total",
                    text: $text,
                    bgColor: .clear)
                    .keyboardType(.numberPad)

                Button {
                    action(text.isEmpty ? "0" : text)
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
        ActivitySerieInputAlertView(goal: "12") { text in
            print(text)
        }
    }
}
