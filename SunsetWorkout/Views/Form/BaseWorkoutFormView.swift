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
        Section {
            Picker("", selection: $type) {
                ForEach(SWWorkoutType.allCases, id: \.self) { workoutType in
                    Text(workoutType.name)
                        .tag(workoutType.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            FloatingTextField(
                placeHolder: "workout.name",
                text: $name,
                bgColor: Color(.clear)) {
                    Text("workout.name")
                }
            
            FloatingTextField(
                placeHolder: SWMetadataType.exerciseBreak.label,
                placeHolderSuffix: "secs",
                text: $exerciseBreak,
                bgColor: Color(.clear)) {
                    Text(SWMetadataType.exerciseBreak.label)
                }
            .keyboardType(.numberPad)
        }
    }
}

#if DEBUG
struct BaseWorkoutFormView_Previews: PreviewProvider {
    static var previews: some View {
        BaseWorkoutFormView(
            type: .constant(.highIntensityIntervalTraining),
            name: .constant("Preview"),
            exerciseBreak: .constant("30"))
    }
}
#endif
