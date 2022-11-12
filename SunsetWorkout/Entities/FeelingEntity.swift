//
//  FeelingEntity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 01/10/2022.
//

import SwiftUI
import RealmSwift

class FeelingEntity: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var created_at: Date
    @Persisted var rawType: String
}

// MARK: - init from Model
extension FeelingEntity {
    convenience init(feeling: Feeling) {
        self.init()

        if feeling.id.count > 0 {
            self._id = feeling.id
        }

        self.rawType = feeling.type.rawValue
    }
}
