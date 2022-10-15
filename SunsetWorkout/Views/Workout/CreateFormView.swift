//
//  CreateFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 22/09/2022.
//

import SwiftUI
import HealthKit

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
                BaseWorkoutFormView(
                    type: $type,
                    name: $name,
                    exerciseBreak: $exerciseBreak)

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
