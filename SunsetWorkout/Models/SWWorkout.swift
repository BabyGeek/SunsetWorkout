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
        self.exercises = exercises?.sorted(by: \.order) ?? []
    }

    mutating func cleanMetadata() {
        metadata = metadata.filter { type.SWMetadataTypes.contains($0.type) }
    }

    func exerciseOrderIsGood() -> Bool {
        if exercises.isEmpty {
            return true
        }

        for index in 0..<exercises.count - 1 where exercises[index].order == exercises[index + 1].order {
            return false
        }

        return true
    }

    func estimatedTime() -> Int {
        var estimatedTime = 0

        if exercises.isEmpty {
            return estimatedTime
        }

        if self.type == .highIntensityIntervalTraining {
            estimatedTime = estimatedTimeForHIIT()
        }

        if self.type == .traditionalStrengthTraining {
            estimatedTime = estimatedTimeForStrength()
        }

        return estimatedTime / 60
    }

    func estimatedTimeForHIIT() -> Int {
        var estimatedTime = 0

        for exercise in exercises {
            if let roundNumber = exercise.metadata.first(where: { $0.type == .roundNumber }),
               let roundBreak = exercise.metadata.first(where: { $0.type == .roundBreak }),
               let roundDuration = exercise.metadata.first(where: { $0.type == .roundDuration }),
               let exerciseBreak = exercise.metadata.first(where: { $0.type == .exerciseBreak }) {
                estimatedTime += roundNumber.intValue * roundDuration.intValue

                if exercise != exercises.last {
                    estimatedTime += roundBreak.intValue
                    if let mainExerciseBreak = metadata.first(where: { $0.type == .exerciseBreak }) {
                        if mainExerciseBreak.intValue != exerciseBreak.intValue {
                            estimatedTime += exerciseBreak.intValue
                        } else {
                            estimatedTime += mainExerciseBreak.intValue
                        }
                    }
                }
            }
        }

        return estimatedTime
    }

    func estimatedTimeForStrength() -> Int {
        var estimatedTime = 0

        for exercise in exercises {
            if let serieNumber = exercise.metadata.first(where: { $0.type == .serieNumber }),
               let serieBreak = exercise.metadata.first(where: { $0.type == .serieBreak }),
               let exerciseBreak = exercise.metadata.first(where: { $0.type == .exerciseBreak }) {
                estimatedTime += ((serieNumber.intValue - 1) * serieBreak.intValue)

                if exercise != exercises.last {
                    if let mainExerciseBreak = metadata.first(where: { $0.type == .exerciseBreak }) {
                        if mainExerciseBreak.intValue != exerciseBreak.intValue {
                            estimatedTime += exerciseBreak.intValue
                        } else {
                            estimatedTime += mainExerciseBreak.intValue
                        }
                    }
                }
            }
        }

        return estimatedTime
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
        self.exercises = object.exercises.map { SWExercise(object: $0) }.sorted(by: { $0.order < $1.order })
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

// MARK: - Activity methods
extension SWWorkout {
    func getFirstExercise() -> SWExercise? {
        exercises.first
    }

    func getExerciseOrder(_ order: Int) -> SWExercise? {
        exercises.first(where: { $0.order == order })
    }

    func isLastExercise(_ exercise: SWExercise?) -> Bool {
        guard let last = exercises.last else { return false }
        dump(last == exercise)
        return last == exercise
    }
}
