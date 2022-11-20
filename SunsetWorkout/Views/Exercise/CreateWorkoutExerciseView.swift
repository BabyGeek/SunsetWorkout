//
//  CreateWorkoutExerciseView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 17/10/2022.
//

import SwiftUI

struct CreateWorkoutExerciseView: View, KeyboardReadable {
    @StateObject var viewModel: WorkoutViewModel

    @State var isKeyboardVisible: Bool = false

    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                Spacer()

                WorkoutExerciseFormView(viewModel.workout?.id ?? "")
            }
            .endTextEditing(including: isKeyboardVisible ? .all : .subviews)
        }
        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
            isKeyboardVisible = newIsKeyboardVisible
        }
        .navigationTitle(NSLocalizedString("exercise.add", comment: "Add exercise title"))
        .toastWithError($viewModel.error)
    }
}

#if DEBUG
struct CreateWorkoutExerciseView_Previews: PreviewProvider {
    static let HIITExample = SWWorkout(name: "Test HIIT", type: .highIntensityIntervalTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "20"),
        SWMetadata(type: .roundBreak, value: "10"),
        SWMetadata(type: .roundNumber, value: "5")
    ])

    static var previews: some View {
        CreateWorkoutExerciseView(viewModel: WorkoutViewModel(workout: HIITExample))
    }
}
#endif
