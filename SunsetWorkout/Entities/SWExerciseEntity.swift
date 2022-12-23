//
//  SWExerciseEntity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 22/10/2022.
//

import Foundation
import RealmSwift

class SWExerciseEntity: Object {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted(originProperty: "exercises") var assignee: LinkingObjects<SWWorkoutEntity>
    @Persisted var rawType: String
    @Persisted var created_at = Date()
    @Persisted var name: String
    @Persisted var order: Int
    @Persisted var metadata = List<SWWorkoutMetadataEntity>()
}

// MARK: - init from Model
extension SWExerciseEntity {
    convenience init(exercise: SWExercise) {
        self.init()

        if exercise.id.count > 0 {
            self._id = exercise.id
        }

        self.name = exercise.name
        self.order = exercise.order
        self.created_at = exercise.createdAt
        self.metadata.append(objectsIn: exercise.metadata.map({ SWWorkoutMetadataEntity(metadata: $0) }))
    }
}
