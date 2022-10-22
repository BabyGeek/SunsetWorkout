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
