//
//  WorkoutView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct WorkoutView: View {
    @ObservedObject var viewModel: WorkoutViewModel
    @ObservedObject var navigationCoordinator: NavigationCoordinator = .shared

    init(workout: SWWorkout) {
        _viewModel = ObservedObject(
            wrappedValue: WorkoutViewModel(workout: workout)
        )
        
        if #unavailable(iOS 16.0) {
            UITableView.appearance().backgroundColor = .clear
        }
    }

    var body: some View {
        VStack {
            if viewModel.getExercises().isEmpty {
                VStack(alignment: .center) {
                    Spacer()
                    Text("workout.exercises.empty")
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            } else {
                List(viewModel.getExercises()) { exercise in
                    Text(exercise.name)
                }
                .clearListBackground()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationTitle(viewModel.workout?.name ??
                         NSLocalizedString("workout.name.not.found", comment: "Label workout name not found"))
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                if let workout = viewModel.workout {
                    NavigationLink(
                        destination: ActivityView(workout: workout),
                        label: {
                            Image(systemName: "play")
                        })
                }
                NavigationLink(
                    destination: CreateWorkoutExerciseView(viewModel: viewModel),
                    label: {
                        Image(systemName: "plus")
                    })
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navigationCoordinator.selectionFromTabBarItem(.activities)
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.left")
                        Text("button.back")
                    }
                }
            }

        }
        .toastWithError($viewModel.error)
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
