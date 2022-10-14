//
//  SWMetadata.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

struct SWMetadata {
    let type: SWMetadataType
    let value: String
}

extension SWMetadata {
    init(object: SWWorkoutMetadataModel) {
        guard let type = SWMetadataType(rawValue: object.rawType) else {
            fatalError("Rating is invalid")
        }

        self.type = type
        self.value = object.value
    }
}
