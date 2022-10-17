//
//  CreateWorkoutExerciceView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 17/10/2022.
//

import SwiftUI

struct CreateWorkoutExerciceView: View, KeyboardReadable {
    var workout: SWWorkout

    @State var isKeyboardVisible: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundView()

                VStack {
                    Spacer()

                    WorkoutExerciceFormView(workout)
                }
                .padding(.horizontal)
                .padding(.bottom, isKeyboardVisible ? 0 : geometry.size.height/8)
                .endTextEditing(including: isKeyboardVisible ? .all : .subviews)
            }
        }
        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
            isKeyboardVisible = newIsKeyboardVisible
        }
        .navigationTitle(NSLocalizedString("exercice.add", comment: "Add exercice title"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreateWorkoutExerciceView_Previews: PreviewProvider {
    static let HIITExample = SWWorkout(name: "Test HIIT", type: .highIntensityIntervalTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "20"),
        SWMetadata(type: .roundBreak, value: "10"),
        SWMetadata(type: .roundNumber, value: "5")
    ])

    static var previews: some View {
        CreateWorkoutExerciceView(workout: HIITExample)
    }
}
