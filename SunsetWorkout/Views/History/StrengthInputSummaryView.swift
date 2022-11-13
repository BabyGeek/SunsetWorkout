//
//  StrengthInputSummaryView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/11/2022.
//

import SwiftUI

struct StrengthInputSummaryView: View {
    let inputs: [ActivityStrengthInput]
    let exerciseName: String
    let exerciseGoal: Int
    @State var selectedInput: ActivityStrengthInput
    @State var selectInputIndex: Int = 0

    var body: some View {
        VStack {
            Text(exerciseName)

            TabView(selection: $selectedInput) {
                ForEach(inputs) { input in
                    StrengthInputRowView(input: input, goal: exerciseGoal)
                        .tag(input)
                }
            }
            .animation(.easeInOut)
            .transition(.slide)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .frame(height: 200)
        .onAppear {
            if let first = inputs.first {
                selectedInput = first
            }
        }
        .onChange(of: selectedInput) { _ in
            if let index = inputs.firstIndex(of: selectedInput) {
                selectInputIndex = index
            }
        }
        .overlay(
            Button(action: {
                selectedInput = inputs[inputs.index(after: selectInputIndex)]
            }, label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.label))
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray)
                            .frame(width: 25, height: 20))
            })
            .padding(.leading)
            .opacity(inputs.index(after: selectInputIndex) < inputs.count ? 1 : 0)
            .buttonStyle(PlainButtonStyle()),
            alignment: .trailing
        )
        .overlay(
            Button(action: {
                selectedInput = inputs[inputs.index(before: selectInputIndex)]
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(.label))
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray)
                            .frame(width: 25, height: 20))
            })
            .padding(.trailing)
            .opacity(inputs.index(before: selectInputIndex) >= 0 ? 1 : 0)
            .buttonStyle(PlainButtonStyle()),
            alignment: .leading
        )
        .padding(.horizontal)
    }
}

struct StrengthInputSummaryView_Previews: PreviewProvider {
    static let strengthInputs = [
        ActivityStrengthInput(serie: 1, repetitions: "12", skipped: false),
        ActivityStrengthInput(serie: 2, repetitions: "12", skipped: false),
        ActivityStrengthInput(serie: 3, repetitions: "11", skipped: false),
        ActivityStrengthInput(serie: 4, repetitions: "10", skipped: false),
        ActivityStrengthInput(serie: 5, repetitions: "8", skipped: false),
        ActivityStrengthInput(serie: 6, repetitions: "0", skipped: true)
    ]

    static var previews: some View {
        StrengthInputSummaryView(
            inputs: strengthInputs,
            exerciseName: "Preview Strength",
            exerciseGoal: 12,
            selectedInput: strengthInputs.first!)
    }
}
