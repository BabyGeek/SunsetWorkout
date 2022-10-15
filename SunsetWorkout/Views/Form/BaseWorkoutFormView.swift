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
                    Text(SWWorkoutType.highIntensityIntervalTraining.name)
                        .tag(SWWorkoutType.highIntensityIntervalTraining)

                    Text(SWWorkoutType.traditionalStrengthTraining.name)
                        .tag(SWWorkoutType.traditionalStrengthTraining)
                }
                .pickerStyle(.segmented)

                FloatingTextField(
                    placeHolder: NSLocalizedString("workout.name", comment: "Workout name label"),
                    text: $name,
                    bgColor: Color(.systemBackground))

                FloatingTextField(
                    placeHolder: "\(SWMetadataType.exerciseBreak.label) (secs)",
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
