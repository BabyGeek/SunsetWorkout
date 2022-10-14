//
//  SWWorkout.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import Foundation

struct SWWorkout {
    var id: String = UUID().uuidString
    let name: String
    let type: SWWorkoutType

    var metadata: [SWMetadata]

    mutating func cleanMetadata() {
        metadata = metadata.filter { type.SWMetadataTypes.contains($0.type) }
    }
}

extension SWWorkout {
    init(object: SWWorkoutModel) {
        guard let type = SWWorkoutType(rawValue: object.rawType) else {
            fatalError("Rating is invalid")
        }

        self.id = object._id
        self.type = type
        self.name = object.name
        self.metadata = object.metadata.map { SWMetadata(object: $0) }
    }
}
