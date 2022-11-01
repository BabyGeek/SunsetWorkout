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
    var shouldHaveBackground: Bool = false

    init(shouldHaveBackground: Bool = false) {
        self.shouldHaveBackground = shouldHaveBackground
    }

    var body: some View {
        if shouldHaveBackground {
            ZStack {
                BackgroundView()

                form
            }
        } else {
            form
        }
    }
}

extension CreateFormView {
    var form: some View {
            VStack {
                Spacer()
                    .frame(height: 20)

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

                Button {
                    saveWorkout()
                } label: {
                    saveButton
                }
                .ignoresSafeArea(.keyboard)

                NavigationLink(isActive: $goToWorkoutView) {
                    WorkoutView(viewModel: workoutViewModel)
                } label: {
                    EmptyView()
                }
            }
            .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                isKeyboardVisible = newIsKeyboardVisible
            }
            .padding()
    }
    var saveButton: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(height: 50)
            .overlay(
                Text(NSLocalizedString("button.save", comment: "Button save title"))
                    .foregroundColor(Color(.label))
            )
    }

    func saveWorkout() {
        workoutViewModel.saveWorkout(isNew: true)
        if workoutViewModel.error == nil && workoutViewModel.saved {
            AnalyticsManager.logCreatedWorkout(type: workoutViewModel.workout?.type)
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
