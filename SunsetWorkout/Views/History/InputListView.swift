//
//  InputListView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 19/11/2022.
//

import SwiftUI

struct InputListView<TitleContent: View, InputContent: View, ListItem: Identifiable, T: Identifiable>: View {
    let inputTitleView: (ListItem) -> TitleContent
    let exercises: [ListItem]
    let inputsKeyPath: KeyPath<ListItem, [T]>
    let inputTagKeyPath: KeyPath<ListItem, String>
    let inputItemView: (T, String) -> InputContent

    init(exercises: [ListItem],
         inputsKeyPath: KeyPath<ListItem, [T]>,
         inputTagKeyPath: KeyPath<ListItem, String>,
         inputTitleView: @escaping (ListItem) -> TitleContent,
         inputItemView: @escaping (T, String) -> InputContent) {
        self.inputTitleView = inputTitleView
        self.inputTagKeyPath = inputTagKeyPath
        self.exercises = exercises
        self.inputsKeyPath = inputsKeyPath
        self.inputItemView = inputItemView
    }

    var body: some View {
        TabView {
            ForEach(exercises) { exercise in
                ScrollView(showsIndicators: false) {
                    VStack {
                        inputTitleView(exercise)
                        ForEach(exercise[keyPath: inputsKeyPath]) { input in
                            inputItemView(input, exercise[keyPath: inputTagKeyPath])
                        }
                    }
                    .tag(exercise[keyPath: inputTagKeyPath])
                }
            }
        }
        .frame(maxHeight: UIScreen.main.bounds.height - 200)
        .transition(.scale)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct InputListView_Previews: PreviewProvider {
    static var inputsHIIT: [ActivityHIITInputs] = []
    static var previews: some View {
        InputListView(
            exercises: inputsHIIT,
            inputsKeyPath: \.inputs,
            inputTagKeyPath: \.exerciseUUID) { _ in
                Text("Preview")
            } inputItemView: { (input, _) in
                HIITInputRowView(input: input)
            }
    }
}
