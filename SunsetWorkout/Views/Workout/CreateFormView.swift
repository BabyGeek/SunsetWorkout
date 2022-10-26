//
//  CreateFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 22/09/2022.
//

import SwiftUI
import HealthKit

struct CreateFormView: View, KeyboardReadable {
    @StateObject var workoutViewModel: WorkoutViewModel = WorkoutViewModel()

    @State var isKeyboardVisible: Bool = false
    @State var goToWorkoutView: Bool = false

    var body: some View {
        VStack {
            Spacer()
            BaseWorkoutFormView(
                type: $workoutViewModel.type,
                name: $workoutViewModel.name,
                exerciseBreak: $workoutViewModel.exerciseBreak)

            if workoutViewModel.type == .highIntensityIntervalTraining {
                HIITFormView(
                    roundBreak: $workoutViewModel.roundBreak,
                    roundDuration: $workoutViewModel.roundDuration,
                    roundNumber: $workoutViewModel.roundNumber)
            }

            if workoutViewModel.type == .traditionalStrengthTraining {
                TraditionalFormView(
                    seriesBreak: $workoutViewModel.seriesBreak,
                    seriesNumber: $workoutViewModel.seriesNumber,
                    repetitionGoal: $workoutViewModel.repetitionGoal)
            }

            Spacer()

            if !isKeyboardVisible {
                Button {
                    saveWorkout()
                } label: {
                    saveButton
                }

                NavigationLink(isActive: $goToWorkoutView) {
                    WorkoutView(viewModel: workoutViewModel)
                } label: {
                    EmptyView()
                }
            }
        }
        .ignoresSafeArea(.keyboard)
        .padding()
        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
            isKeyboardVisible = newIsKeyboardVisible
        }
    }
}

extension CreateFormView {
    var saveButton: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 50)
            .overlay(
                Text(NSLocalizedString("button.save", comment: "Button save title"))
                    .foregroundColor(Color(.label))
            )
    }

    func saveWorkout() {
        workoutViewModel.saveWorkout()
        if workoutViewModel.error == nil {
            goToWorkoutView = true
        }
    }
}

#if DEBUG
struct CreateFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFormView()
    }
}
#endif
