//
//  WorkoutViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import SwiftUI
import RealmSwift

class WorkoutViewModel: ObservableObject {
    @Published var error: SWError?
    @Published var workout: SWWorkout?
    @Published var saved: Bool = false

    let realmManager = RealmManager()

    init(error: SWError? = nil, workout: SWWorkout? = nil, saved: Bool = false) {
        self.error = error
        self.workout = workout
        self.saved = saved
    }

    public func saveWorkout() {
        workout?.cleanMetadata()

        if let workout {
            if workout.exerciseOrderIsGood() {
                self.error = SWError(error: SWExerciseError.severalOrders)
            }

            save(model: workout, with: SWWorkoutModel.init)
        }
    }

    public func addExercise(_ exercise: SWExercise) {
        guard let exercise = validateExercise(exercise) else { return }
        workout?.exercises.replaceOrAppend(exercise, whereFirstIndex: { exercise.id == $0.id })
    }

    func save(model: SWWorkout, with reverseTransformer: (SWWorkout) -> SWWorkoutModel) {
        saved = false
        do {
            try realmManager.save(model: model, with: reverseTransformer)
            saved = true
        } catch {
            self.error = SWError(error: error)
        }
    }

    private func validateExercise(_ exercise: SWExercise) -> SWExercise? {
        if exercise.name.isEmpty {
            self.error = SWError(error: SWExerciseError.noName)
            return nil
        }

        return exercise
    }
}
