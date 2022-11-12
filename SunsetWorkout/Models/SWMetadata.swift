//
//  SWMetadata.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import Foundation

struct SWMetadata {
    var id: String = UUID().uuidString
    let type: SWMetadataType
    let value: String

    var intValue: Int {
        Int(value) ?? 0
    }

    var floatValue: Float {
        Float(value) ?? 0
    }
}

// MARK: - init from RealmObject
extension SWMetadata {
    init(object: SWWorkoutMetadataEntity) {
        guard let type = SWMetadataType(rawValue: object.rawType) else {
            fatalError("Metadata type is invalid")
        }

        self.type = type
        self.value = object.value
    }
}

// MARK: - Identifiable
extension SWMetadata: Identifiable { }

// MARK: - Equatable
extension SWMetadata: Equatable {
    static func == (lhs: SWMetadata, rhs: SWMetadata) -> Bool {
        return lhs.id == rhs.id
    }
}
