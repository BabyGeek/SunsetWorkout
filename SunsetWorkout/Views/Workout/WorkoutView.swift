//
//  WorkoutView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct WorkoutView: View {
    @StateObject var viewModel: WorkoutViewModel

    init(viewModel: WorkoutViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        UICollectionView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack {
            BackgroundView()
            if let workout = viewModel.workout {
                if workout.exercises.isEmpty {
                    Spacer()
                    Text("workout.exercises.empty")
                    Spacer()
                }

                List {
                    ForEach(workout.exercises) { exercise in
                        VStack(spacing: 0) {
                            Text(exercise.name)

                            if exercise != workout.exercises.last {
                                Rectangle()
                                    .fill(.purple)
                                    .blur(radius: 1.5)
                                    .frame(maxWidth: .infinity, maxHeight: 0.5, alignment: .center)
                                    .padding(.horizontal)
                                    .padding(.top)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                NavigationLink(destination: EmptyView()) {
                    EmptyView()
                }
            }
        }
        .navigationTitle(viewModel.workout?.name ??
                         NSLocalizedString("workout.name.not.found", comment: "Label workout name not found"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                NavigationLink(
                                    destination: CreateWorkoutExerciseView(viewModel: viewModel),
                                    label: {
                                        Image(systemName: "plus")
                                    })
        )
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
        WorkoutView(viewModel: WorkoutViewModel(workout: HIITExample))
    }
}
