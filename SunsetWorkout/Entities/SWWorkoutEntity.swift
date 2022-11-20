//
//  SWWorkoutEntity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import Foundation
import RealmSwift

class SWWorkoutEntity: Object {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var created_at = Date()
    @Persisted var rawType: String
    @Persisted var name: String
    @Persisted var metadata = List<SWWorkoutMetadataEntity>()
    @Persisted var exercises = List<SWExerciseEntity>()
}

// MARK: - init from Model
extension SWWorkoutEntity {
    convenience init(workout: SWWorkout) {
        self.init()

        if workout.id.count > 0 {
            self._id = workout.id
        }

        self.name = workout.name
        self.rawType = workout.type.rawValue
        self.metadata.append(objectsIn: workout.metadata.map({ SWWorkoutMetadataEntity(metadata: $0) }))
        self.exercises.append(objectsIn: workout.exercises.map({ SWExerciseEntity(exercise: $0) }))
        self.created_at = workout.createdAt
    }
}

// MARK: - Checks
extension SWWorkoutEntity {
    func exerciseOrderIsGood() -> Bool {
        if exercises.isEmpty {
            return true
        }

        for index in 0..<exercises.count - 1 where exercises[index].order == exercises[index + 1].order {
            return false
        }

        return true
    }
}
