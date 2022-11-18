//
//  StrengthInputSummaryView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/11/2022.
//

import SwiftUI

struct StrengthInputSummaryView: View {
    let inputs: [ActivityStrengthInput]
    let exerciseGoal: Int

    var body: some View {
        ScrollView {
            ForEach(inputs) { input in
                StrengthInputRowView(input: input, goal: exerciseGoal)
            }
        }
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
            exerciseGoal: 12)
    }
}
