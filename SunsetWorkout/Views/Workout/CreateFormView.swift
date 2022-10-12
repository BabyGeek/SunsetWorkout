//
//  CreateFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 22/09/2022.
//

import SwiftUI
import HealthKit

struct HIITFormView: View {
    @Binding var roundBreak: String
    @Binding var roundNumber: String

    var body: some View {
        FloatingTextField(placeHolder: "Round break (secs)", text: $roundBreak, bgColor: Color(.systemBackground))
            .keyboardType(.numberPad)

        FloatingTextField(placeHolder: "Round number", text: $roundNumber, bgColor: Color(.systemBackground))
            .keyboardType(.numberPad)

    }
}

struct TraditionalFormView: View {
    @Binding var seriesBreak: String
    @Binding var seriesNumber: String
    @Binding var repetitionGoal: String

    var body: some View {
        FloatingTextField(
            placeHolder: "Series break (secs)",
            text: $seriesBreak,
            bgColor: Color(.systemBackground))
            .keyboardType(.numberPad)

        FloatingTextField(
            placeHolder: "Series number",
            text: $seriesNumber,
            bgColor: Color(.systemBackground))
            .keyboardType(.numberPad)

        FloatingTextField(
            placeHolder: "Series repetition goal",
            text: $repetitionGoal,
            bgColor: Color(.systemBackground))
            .keyboardType(.numberPad)
    }
}

struct CreateFormView: View {
    @ObservedObject var workoutViewModel: WorkoutViewModel = WorkoutViewModel()

    @State private var type: SWWorkoutType = .highIntensityIntervalTraining

    @State private var name: String = ""
    @State private var exerciseBreak: String = ""

    @State var roundBreak: String = ""
    @State var roundNumber: String = ""

    @State var seriesBreak: String = ""
    @State var seriesNumber: String = ""
    @State var repetitionGoal: String = ""

    var body: some View {
        NavigationView {
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

                if type == .highIntensityIntervalTraining {
                    HIITFormView(
                        roundBreak: $roundBreak,
                        roundNumber: $roundNumber)
                }

                if type == .traditionalStrengthTraining {
                    TraditionalFormView(
                        seriesBreak: $seriesBreak,
                        seriesNumber: $seriesNumber,
                        repetitionGoal: $repetitionGoal)
                }

                Spacer()

                Button {
                    workoutViewModel.workout = SWWorkout(name: name, type: type, metadata: [
                        SWMetadata(type: .roundBreak, value: roundBreak),
                        SWMetadata(type: .roundNumber, value: roundNumber),
                        SWMetadata(type: .exerciseBreak, value: exerciseBreak),
                        SWMetadata(type: .serieBreak, value: seriesBreak),
                        SWMetadata(type: .serieNumber, value: seriesNumber),
                        SWMetadata(type: .repetitionGoal, value: repetitionGoal)
                    ])
                    workoutViewModel.saveWorkout()
                    
                    if workoutViewModel.saved {
                        name = ""
                        roundBreak = ""
                        roundNumber = ""
                        exerciseBreak = ""
                        seriesBreak = ""
                        seriesNumber = ""
                        repetitionGoal = ""
                        
                        workoutViewModel.saved = false
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 50)
                        .overlay(
                            Text("Save")
                                .foregroundColor(Color(.label))
                        )
                }

            }
            .navigationTitle("New workout")
            .padding()
        }
    }
}

struct CreateFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFormView()
    }
}
