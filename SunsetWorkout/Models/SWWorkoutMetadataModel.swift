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

    var type: SWMetadataType {
        get { return SWMetadataType(rawValue: rawType) ?? SWMetadataType.exerciseBreak }
        set { rawType = newValue.rawValue }
    }

    convenience init(metadata: SWMetadata) {
        self.init()

        self.rawType = metadata.type.rawValue
        self.value = metadata.value
    }
}
