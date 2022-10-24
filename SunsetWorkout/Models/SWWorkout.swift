//
//  SWWorkout.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import Foundation

struct SWWorkout {
    var id: String
    let name: String
    let type: SWWorkoutType
    let createdAt: Date

    var metadata: [SWMetadata]
    var exercises: [SWExercise]

    init(
        id: UUID = UUID(),
        name: String,
        type: SWWorkoutType,
        createdAt: Date = Date(),
        metadata: [SWMetadata],
        exercises: [SWExercise]? = nil) {
        self.id = id.uuidString
        self.name = name
        self.type = type
        self.createdAt = createdAt
        self.metadata = metadata
        self.exercises = exercises ?? []
    }

    mutating func cleanMetadata() {
        metadata = metadata.filter { type.SWMetadataTypes.contains($0.type) }
    }

    func exerciseOrderIsGood() -> Bool {
        return exercises.allEqual(by: \.order)
    }
}

// MARK: - Identifiable
extension SWWorkout: Identifiable { }

// MARK: - Equatable
extension SWWorkout: Equatable {
    static func == (lhs: SWWorkout, rhs: SWWorkout) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - init from RealmObject
extension SWWorkout {
    init(object: SWWorkoutModel) {
        guard let type = SWWorkoutType(rawValue: object.rawType) else {
            fatalError("Workout type is invalid")
        }

        self.id = object._id
        self.type = type
        self.name = object.name
        self.metadata = object.metadata.map { SWMetadata(object: $0) }
        self.exercises = object.exercises.map { SWExercise(object: $0) }
        self.createdAt = object.created_at
    }
}

// MARK: - Mock data
extension SWWorkout {
    static func getMockWithName(
        _ name: String,
        type: SWWorkoutType,
        metadata: [SWMetadata]? = nil,
        exercises: [SWExercise]? = nil) -> SWWorkout {
        let metadata = metadata ?? [
            SWMetadata(type: .exerciseBreak, value: "120"),
            SWMetadata(type: .roundBreak, value: "10"),
            SWMetadata(type: .serieBreak, value: "20"),
            SWMetadata(type: .roundNumber, value: "5"),
            SWMetadata(type: .serieNumber, value: "6"),
            SWMetadata(type: .repetitionGoal, value: "12"),
            SWMetadata(type: .roundDuration, value: "20")
        ]

        return SWWorkout(
            name: name,
            type: type,
            metadata: metadata,
            exercises: exercises)
    }
}
