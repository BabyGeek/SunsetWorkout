//
//  SWExercise.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 21/10/2022.
//

import Foundation

struct SWExercise {
    var id: String
    let name: String
    let order: Int
    let createdAt: Date

    var metadata: [SWMetadata]

    init(id: UUID = UUID(), name: String, order: Int, createdAt: Date = Date(), metadata: [SWMetadata]) {
        self.id = id.uuidString
        self.name = name
        self.order = order
        self.createdAt = createdAt
        self.metadata = metadata
    }
}

// MARK: - Identifiable
extension SWExercise: Identifiable { }

// MARK: - Equatable
extension SWExercise: Equatable {
    static func == (lhs: SWExercise, rhs: SWExercise) -> Bool {
        return lhs.id == rhs.id && lhs.order == rhs.order
    }
}

// MARK: - init from RealmObject
extension SWExercise {
    init(object: SWExerciseModel) {
        self.id = object._id
        self.name = object.name
        self.order = object.order
        self.createdAt = object.created_at
        self.metadata = object.metadata.map { SWMetadata(object: $0) }
    }
}

// MARK: - Static mock data
extension SWExercise {
    static func getMockWithName(_ name: String, for workout: SWWorkout?, order: Int? = nil) -> SWExercise {
        var metadata: [SWMetadata] = []
        var exerciseOrder: Int = 1

        if let workout {
            metadata = [
                SWMetadata(type: .exerciseBreak, value: "30"),
                SWMetadata(type: .roundBreak, value: "20"),
                SWMetadata(type: .roundNumber, value: "6"),
                SWMetadata(type: .roundDuration, value: "30"),
                SWMetadata(type: .serieBreak, value: "20"),
                SWMetadata(type: .serieNumber, value: "6"),
                SWMetadata(type: .repetitionGoal, value: "12")
            ].filter({ workout.type.SWMetadataTypes.contains($0.type) })

            exerciseOrder = order ?? workout.exercises.count + 1
        }

        return SWExercise(name: name, order: exerciseOrder, metadata: metadata)
    }
}

// MARK: - Activity method
extension SWExercise {
    func getMetadataFor(_ type: SWWorkoutType, completion: @escaping ((Float?, Float?, Int?, Float?) -> Void)) {
        let exerciseBreakHIIT = metadata.first(where: { $0.type == .roundBreak })?.floatValue
        let exerciseRepetitionHIIT = metadata.first(where: { $0.type == .roundNumber })?.intValue
        let goalHIIT = metadata.first(where: { $0.type == .roundDuration })?.floatValue

        let exerciseBreakStrength = metadata.first(where: { $0.type == .serieBreak })?.floatValue
        let exerciseRepetitionStrength = metadata.first(where: { $0.type == .serieNumber })?.intValue
        let goalStrength = metadata.first(where: { $0.type == .repetitionGoal })?.floatValue

        let exerciceEndBreak = metadata.first(where: { $0.type == .exerciseBreak })?.floatValue

        if type == .highIntensityIntervalTraining {
            completion(exerciceEndBreak, exerciseBreakHIIT, exerciseRepetitionHIIT, goalHIIT)
        }

        if type == .traditionalStrengthTraining {
            completion(exerciceEndBreak, exerciseBreakStrength, exerciseRepetitionStrength, goalStrength)
        }
    }
}
