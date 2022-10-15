//
//  BaseWorkoutFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 15/10/2022.
//

import SwiftUI

struct BaseWorkoutFormView: View {
    @Binding var type: SWWorkoutType
    @Binding var name: String
    @Binding var exerciseBreak: String

    var body: some View {
        VStack {
                Picker("Type", selection: $type) {
                    Text(SWWorkoutType.highIntensityIntervalTraining.rawValue)
                        .tag(SWWorkoutType.highIntensityIntervalTraining)

                    Text(SWWorkoutType.traditionalStrengthTraining.rawValue)
                        .tag(SWWorkoutType.traditionalStrengthTraining)
                }
                .pickerStyle(.segmented)

                FloatingTextField(
                    placeHolder: "Name",
                    text: $name,
                    bgColor: Color(.systemBackground))

                FloatingTextField(
                    placeHolder: "Exercice break (secs)",
                    text: $exerciseBreak,
                    bgColor: Color(.systemBackground))
                    .keyboardType(.numberPad)
        }
    }
}

struct BaseWorkoutFormView_Previews: PreviewProvider {
    static var previews: some View {
        BaseWorkoutFormView(
            type: .constant(.highIntensityIntervalTraining),
            name: .constant("Preview"),
            exerciseBreak: .constant("30"))
    }
}
