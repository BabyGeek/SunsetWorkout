//
//  SWActivitySummary.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/11/2022.
//

import Foundation
import HealthKit

struct SWActivitySummary {
    var id: String = UUID().uuidString
    let workout: SWWorkout
    let type: SWWorkoutType
    let inputs: [String: [[String: Any]]]
    let startDate: Date
    let endDate: Date
    let duration: TimeInterval
    let totalEnergyBurned: Double
    let events: [HKWorkoutEvent]
    let endedWithState: SWActivityState
    var formattedInputsHIIT: [ActivityHIITInputs] = []
    var formattedInputsStrength: [ActivityStrengthInputs] = []

    var date: String {
        let formater = DateFormatter()
        formater.dateStyle = .medium

        return formater.string(from: startDate)
    }

    var title: String {
        String(format: "%@ - %@", workout.name, date)
    }

    var totalEnergyBurnedQuantity: HKQuantity {
        HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: totalEnergyBurned)
    }

    var workoutHK: HKWorkout {
        HKWorkout(
            activityType: type.HKWorkoutActivityType,
            start: startDate,
            end: endDate,
            duration: duration,
            totalEnergyBurned: totalEnergyBurnedQuantity,
            totalDistance: nil,
            metadata: nil)
    }

    /// Get exercise from his ID
    /// - Parameter exerciseID: `String` UUID String of the exercise
    /// - Returns: `String` name of the exercise or not found text
    func getExerciseFromID(_ exerciseID: String) -> SWExercise? {
        guard let exercise = workout.exercises.first(where: { $0.id == exerciseID }) else { return nil }

        return exercise
    }

    /// Get exercise name from his ID
    /// - Parameter exerciseID: `String` UUID String of the exercise
    /// - Returns: `String` name of the exercise or not found text
    func getExerciseNameFromID(_ exerciseID: String) -> String {
        let notFoundString = NSLocalizedString("not.found", comment: "Not found")
        guard let exercise = getExerciseFromID(exerciseID) else { return notFoundString }

        return exercise.name
    }

    /// Get workout goal number if it has been set up
    /// - Returns: `Int`
    func getGoal() -> Int {
        guard let goal = workout.metadata.first(where: { $0.type == .repetitionGoal }) else { return 0 }

        return goal.intValue
    }

    /// Get exercise goal from exercise ID
    /// - Parameter exerciseID: `String`
    /// - Returns: `Int`
    func getExerciseGoal(_ exerciseID: String) -> Int {
        guard let exercise = getExerciseFromID(exerciseID) else { return 0 }

        return exercise.getGoal()
    }
}

// MARK: - Identifiable
extension SWActivitySummary: Identifiable { }

// MARK: - Equatable
extension SWActivitySummary: Equatable {
    static func == (lhs: SWActivitySummary, rhs: SWActivitySummary) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - init from RealmObject
extension SWActivitySummary {
    init(object: SWActivitySummaryEntity) {
        guard let type = SWWorkoutType(rawValue: object.rawType) else {
            fatalError("Workout type is invalid")
        }

        guard let state = SWActivityState(rawValue: object.endedWithStateRaw) else {
            fatalError("State is invalid")
        }

        self.id = object._id
        self.workout = SWWorkout(object: object.workout ?? SWWorkoutEntity())
        self.type = type
        self.startDate = object.startDate
        self.endDate = object.endDate
        self.duration = object.duration
        self.totalEnergyBurned = object.totalEnergyBurned
        self.endedWithState = state
        self.events = []
        self.inputs = [:]

        self.formattedInputsHIIT = object.inputsHIIT.map({
            ActivityHIITInputs(object: $0)
        }).sorted(by: \.exerciseOrder)

        self.formattedInputsStrength = object.inputsStrength.map({
            ActivityStrengthInputs(object: $0)
        }).sorted(by: \.exerciseOrder)
    }
}
