//
//  CreateFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 22/09/2022.
//

import SwiftUI
import HealthKit

struct CreateFormView: View {
    @StateObject var workoutViewModel: WorkoutViewModel = WorkoutViewModel()
    @State var goToWorkoutView: Bool = false
    @State var selectBaseMetadata: Bool = true
    
    var shouldHaveBackground: Bool = false

    init(shouldHaveBackground: Bool = false) {
        self.shouldHaveBackground = shouldHaveBackground
        
        if #unavailable(iOS 16.0) {
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
        }
    }

    var body: some View {
        VStack {
            form
            Spacer()
            
            HStack {
                SWButton(tint: .green) {
                    Text("button.save")
                } action: {
                    saveWorkout()
                }
                
                NavigationLink(isActive: $goToWorkoutView) {
                    WorkoutView(workout: workoutViewModel.workout ?? SWWorkout(
                        name: "Error",
                        type: .highIntensityIntervalTraining,
                        metadata: []))
                } label: {
                    EmptyView()
                }
                .frame(width: 0)
            }
            .padding()
        }
        .clearListBackground()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toastWithError($workoutViewModel.error)
    }
}

extension CreateFormView {
    var form: some View {
        Form {
            BaseWorkoutFormView(
                type: $workoutViewModel.type,
                name: $workoutViewModel.name,
                exerciseBreak: $workoutViewModel.exerciseBreak)

            switch workoutViewModel.type {
            case .highIntensityIntervalTraining, .cycle:
                HIITFormView(
                    roundBreak: $workoutViewModel.roundBreak,
                    roundDuration: $workoutViewModel.roundDuration,
                    roundNumber: $workoutViewModel.roundNumber)
            case .traditionalStrengthTraining:
                TraditionalFormView(
                    seriesBreak: $workoutViewModel.seriesBreak,
                    seriesNumber: $workoutViewModel.seriesNumber,
                    repetitionGoal: $workoutViewModel.repetitionGoal)
            case .mixed:
                HIITFormView(
                    roundBreak: $workoutViewModel.roundBreak,
                    roundDuration: $workoutViewModel.roundDuration,
                    roundNumber: $workoutViewModel.roundNumber)

                TraditionalFormView(
                    seriesBreak: $workoutViewModel.seriesBreak,
                    seriesNumber: $workoutViewModel.seriesNumber,
                    repetitionGoal: $workoutViewModel.repetitionGoal)
            }
        }
    }

    func saveWorkout() {
        workoutViewModel.saveWorkout(isNew: true)
        if workoutViewModel.error == nil && workoutViewModel.saved {
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
