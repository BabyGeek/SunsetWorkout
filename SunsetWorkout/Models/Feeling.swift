//
//  Feeling.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/10/2022.
//

import Foundation

struct Feeling {
    var id: String = UUID().uuidString
    var type: FeelingType
}

// MARK: - init from RealmObject
extension Feeling {
    init(object: FeelingEntity) {
        guard let type = FeelingType(rawValue: object.rawType) else {
            fatalError("Feeling type is invalid")
        }

        self.id = object._id
        self.type = type
    }
}
