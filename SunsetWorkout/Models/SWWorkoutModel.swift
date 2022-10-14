//
//  SWWorkoutModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import SwiftUI
import RealmSwift

class SWWorkoutModel: Object {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var created_at = Date()
    @Persisted var rawType: String
    @Persisted var name: String
    @Persisted var metadata = RealmSwift.List<SWWorkoutMetadataModel>()
}

// MARK: - init from Model
extension SWWorkoutModel {
    convenience init(workout: SWWorkout) {
        self.init()

        if workout.id.count > 0 {
            self._id = workout.id
        }

        self.name = workout.name
        self.rawType = workout.type.rawValue
        self.metadata.append(objectsIn: workout.metadata.map({ SWWorkoutMetadataModel(metadata: $0) }))
        self.created_at = workout.createdAt
    }
}
