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

    var workoutEntity: SWWorkoutEntity?
    let realmManager = RealmManager()
    var notificationToken: NotificationToken?

    init(workout: SWWorkout? = nil) {
        find(workout?.id ?? "")
        self.error = nil
        self.saved = false

        if let workoutEntity {
            notificationToken = workoutEntity.observe(keyPaths: ["exercises"], { change in
                switch change {
                case .error(let error):
                    self.error = SWError(error: error)
                default:
                    self.find(workoutEntity._id)
                    self.loadEntity()
                }
            })

        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    public func saveWorkout(isNew: Bool = false) {
        saved = false
        error = nil

        if isNew {
            self.createWorkout()
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

        save(model: workout, with: SWWorkoutEntity.init)
    }

    func find(_ id: String? = nil) {
        workout = nil

        if let id {
            do {
                if let workout = try realmManager.fetch(with: SWWorkout.find(id, with: nil)).first {
                    self.workout = workout
                    loadEntity()
                }
            } catch {
                self.error = SWError(error: error)
            }
        }
    }

    func loadEntity() {
        if let workout {
            do {
                self.workoutEntity = try realmManager.fetchEntities(with: SWWorkout.find(workout.id, with: nil)).first
            } catch {
                self.error = SWError(error: error)
            }
        } else {
            guard workout != nil else { return }
            workout = nil
        }
    }

    func save(model: SWWorkout, with reverseTransformer: (SWWorkout) -> SWWorkoutEntity) {
        do {
            try realmManager.save(model: model, with: reverseTransformer)
            resetFormData()

            saved = true
        } catch {
            self.error = SWError(error: error)
        }
    }
    
    func getExercises() -> [SWExercise] {
        workout?.exercises ?? []
    }

    private func refreshWorkout() {
        if let workout {
            find(workout.id)
        }
    }

    private func createWorkout() {
        if self.name.isEmpty {
            self.error = SWError(error: SWWorkoutError.noName)
            return
        }

        self.workout = SWWorkout(name: self.name, type: self.type, metadata: self.getMetadata())
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
        type = .highIntensityIntervalTraining
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
