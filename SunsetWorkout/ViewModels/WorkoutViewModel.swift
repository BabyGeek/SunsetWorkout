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

    @Published var type: SWWorkoutType = .highIntensityIntervalTraining

    @Published var name: String = ""
    @Published var exerciseBreak: String = ""

    @Published var roundBreak: String = ""
    @Published var roundNumber: String = ""
    @Published var roundDuration: String = ""

    @Published var seriesBreak: String = ""
    @Published var seriesNumber: String = ""
    @Published var repetitionGoal: String = ""

    let realmManager = RealmManager()

    init(workout: SWWorkout? = nil, error: SWError? = nil) {
        self.workout = workout
        self.error = error
        self.saved = false
    }

    public func saveWorkout(isNew: Bool = false) {
        saved = false

        if !self.find() || isNew {
            self.createWorkout()
            AnalyticsManager.logCreatingWorkout(type: workout?.type)
        }

        if self.error != nil {
            return
        }

        workout?.cleanMetadata()

        guard let workout else {
            self.error = SWError(error: SWWorkoutError.isNil)
            return
        }

        if !workout.exerciseOrderIsGood() {
            self.error = SWError(error: SWExerciseError.severalOrders)
            return
        }

        save(model: workout, with: SWWorkoutModel.init)
    }

    public func addExercise(_ exercise: SWExercise) {
        guard let exercise = validateExercise(exercise) else { return }
        AnalyticsManager.logAddExercise(type: workout?.type)
        workout?.exercises.replaceOrAppend(exercise, whereFirstIndex: { exercise.id == $0.id })
    }

    func find(_ id: String? = nil) -> Bool {
        if let id {
            do {
                if let workout = try realmManager.fetch(with: SWWorkout.find(id, with: nil)).first {
                    self.workout = workout
                    return true
                }
            } catch {
                self.error = SWError(error: error)
            }
        } else {
            guard workout != nil else { return false }
            return true
        }

        return false
    }

    func save(model: SWWorkout, with reverseTransformer: (SWWorkout) -> SWWorkoutModel) {
        do {
            try realmManager.save(model: model, with: reverseTransformer)

            name = ""
            roundBreak = ""
            roundNumber = ""
            roundDuration = ""
            exerciseBreak = ""
            seriesBreak = ""
            seriesNumber = ""
            repetitionGoal = ""

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

    private func createWorkout() {
        if self.name.isEmpty {
            self.error = SWError(error: SWWorkoutError.noName)
            return
        }

        self.workout = SWWorkout(name: self.name, type: self.type, metadata: self.getMetadata())
    }

    private func getMetadata() -> [SWMetadata] {
        return [
            SWMetadata(type: .roundBreak, value: roundBreak),
            SWMetadata(type: .roundDuration, value: roundDuration),
            SWMetadata(type: .roundNumber, value: roundNumber),
            SWMetadata(type: .exerciseBreak, value: exerciseBreak),
            SWMetadata(type: .serieBreak, value: seriesBreak),
            SWMetadata(type: .serieNumber, value: seriesNumber),
            SWMetadata(type: .repetitionGoal, value: repetitionGoal)
        ]
    }
}
