//
//  SWWorkoutMetadataEntity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import Foundation
import RealmSwift

class SWWorkoutMetadataEntity: Object {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var rawType: String
    @Persisted var value: String
}

// MARK: - init from Model
extension SWWorkoutMetadataEntity {
    convenience init(metadata: SWMetadata) {
        self.init()

        if metadata.id.count > 0 {
            self._id = metadata.id
        }

        self.rawType = metadata.type.rawValue
        self.value = metadata.value
    }
}
