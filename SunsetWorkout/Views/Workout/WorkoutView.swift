//
//  WorkoutView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct WorkoutView: View {
    var workout: SWWorkout
    @State var presentExerciceModal: Bool = false

    var body: some View {
        ZStack {
            BackgroundView()
            Text(workout.name)
        }
        .navigationTitle(workout.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    presentExerciceModal = true
                                }, label: {
                                    Image(systemName: "plus")
                                })
        )
        .sheet(isPresented: $presentExerciceModal) {
            ZStack {
                BackgroundView()

                VStack {
                    HStack {
                        Spacer()
                        Button {
                            presentExerciceModal = false
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                    .padding()
                    Spacer()

                }
            }
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static let HIITExample = SWWorkout(name: "Test HIIT", type: .highIntensityIntervalTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "20"),
        SWMetadata(type: .roundBreak, value: "10"),
        SWMetadata(type: .roundNumber, value: "5")
    ])

    static let StrengthExample = SWWorkout(name: "Test Strength", type: .traditionalStrengthTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "120"),
        SWMetadata(type: .serieBreak, value: "60"),
        SWMetadata(type: .serieNumber, value: "6"),
        SWMetadata(type: .repetitionGoal, value: "12")
    ])

    static var previews: some View {
        WorkoutView(workout: HIITExample)
    }
}
