//
//  SWWorkoutMetadataModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import RealmSwift

class SWWorkoutMetadataModel: Object {
    @Persisted var rawType: String
    @Persisted var value: String
}

// MARK: - init from Model
extension SWWorkoutMetadataModel {
    convenience init(metadata: SWMetadata) {
        self.init()

        self.rawType = metadata.type.rawValue
        self.value = metadata.value
    }
}
