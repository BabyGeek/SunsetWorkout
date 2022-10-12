//
//  SWWorkout.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import Foundation

struct SWWorkout {
    let id: String = UUID().uuidString
    let name: String
    let type: SWWorkoutType

    var metadata: [SWMetadata]

    mutating func cleanMetadata() {
        metadata = metadata.filter { type.SWMetadataTypes.contains($0.type) }
    }
}
