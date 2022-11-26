//
//  WorkoutExerciseViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 20/11/2022.
//

import RealmSwift
import RegexBuilder
import SwiftUI

class WorkoutExerciseViewModel: ObservableObject {
    @Published var error: SWError?
    @Published var exercise: SWExercise?
    @Published var workout: SWWorkoutEntity?
    @Published var workoutUUID: String
    @Published var saved: Bool = false

    @Published var name: String = ""
    @Published var exerciseBreak: String = ""

    @Published var roundBreak: String = ""
    @Published var roundNumber: String = ""
    @Published var roundDuration: String = ""

    @Published var seriesBreak: String = ""
    @Published var seriesNumber: String = ""
    @Published var repetitionGoal: String = ""

    let realmManager = RealmManager()

    var isHIITTraining: Bool {
        workout?.rawType == SWWorkoutType.highIntensityIntervalTraining.rawValue
    }

    var isTraditionalTraining: Bool {
        workout?.rawType == SWWorkoutType.traditionalStrengthTraining.rawValue
    }

    init(workoutUUID: String) {
        self.workoutUUID = workoutUUID
        self.error = nil
        self.saved = false

        if !findWorkout(workoutUUID) {
            self.error = SWError(error: SWWorkoutError.notFound)
        }

        initMetadataWithValues()
    }

    public func saveExercise() {
        saved = false
        error = nil

        if exercise == nil {
            createExercise()
        }

        guard let exercise else {
            error = SWError(error: SWExerciseError.isNil)
            return
        }

        validateExercise()
        save(model: exercise, with: SWExerciseEntity.init)
    }

    func findWorkout(_ id: String) -> Bool {
        do {
            if let workout = try realmManager.fetchEntities(with: SWWorkout.find(id, with: nil)).first {
                self.workout = workout
                return true
            }
        } catch {
            self.error = SWError(error: error)
        }

        return false
    }

    func save(model: SWExercise, with reverseTransformer: (SWExercise) -> SWExerciseEntity) {
        if error == nil {
            do {
                if var workout {
                    try realmManager.saveWithManyRelation(
                        model: model,
                        with: reverseTransformer,
                        on: &workout,
                        withKeyPath: \.exercises)
                    resetFormData()
                    saved = true
                } else {
                    self.error = SWError(error: SWWorkoutError.notFound)
                }
            } catch {
                self.error = SWError(error: error)
            }
        }
    }

    func initMetadataWithValues() {
        if let workout {
            let metadata = workout.metadata
            for data in metadata {
                switch data.rawType {
                case SWMetadataType.exerciseBreak.rawValue:
                    exerciseBreak = data.value
                case SWMetadataType.roundBreak.rawValue:
                    roundBreak = data.value
                case SWMetadataType.roundNumber.rawValue:
                    roundNumber = data.value
                case SWMetadataType.roundDuration.rawValue:
                    roundDuration = data.value
                case SWMetadataType.serieBreak.rawValue:
                    seriesBreak = data.value
                case SWMetadataType.serieNumber.rawValue:
                    seriesNumber = data.value
                case SWMetadataType.repetitionGoal.rawValue:
                    repetitionGoal = data.value
                default:
                    break
                }
            }
        }
    }

    private func validateExercise() {
        if let exercise {
            if exercise.name.isEmpty {
                self.error = SWError(error: SWExerciseError.noName)
            }

            if let workout {
                if exercise.order != getExerciseOrder(workout) {
                    self.error = SWError(error: SWExerciseError.severalOrders)
                }
            }

        } else {
            self.error = SWError(error: SWExerciseError.isNil)
        }

    }

    private func createExercise() {
        if let workout, let type = SWWorkoutType(rawValue: workout.rawType) {
            exercise = SWExercise(
                name: name,
                order: getExerciseOrder(workout),
                metadata: getExerciseMetadata(workout, type: type)
            )
        }
    }

    private func getExerciseOrder(_ workout: SWWorkoutEntity) -> Int {
        workout.exercises.count + 1
    }

    private func getExerciseMetadata(_ workout: SWWorkoutEntity, type: SWWorkoutType) -> [SWMetadata] {
        getMetadata().filter({ type.SWMetadataTypes.contains($0.type) })
    }

    private func getMetadata() -> [SWMetadata] {
        [
            SWMetadata(type: .roundBreak, value: roundBreak),
            SWMetadata(type: .roundDuration, value: roundDuration),
            SWMetadata(type: .roundNumber, value: roundNumber),
            SWMetadata(type: .exerciseBreak, value: exerciseBreak),
            SWMetadata(type: .serieBreak, value: seriesBreak),
            SWMetadata(type: .serieNumber, value: seriesNumber),
            SWMetadata(type: .repetitionGoal, value: repetitionGoal)
        ]
    }

    private func resetFormData() {
        name = ""
        roundBreak = ""
        roundNumber = ""
        roundDuration = ""
        exerciseBreak = ""
        seriesBreak = ""
        seriesNumber = ""
        repetitionGoal = ""
    }
}
