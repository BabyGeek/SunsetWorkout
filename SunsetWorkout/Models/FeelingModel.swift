//
//  FeelingModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 01/10/2022.
//

import SwiftUI
import RealmSwift

class FeelingModel: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var created_at: Date
    @Persisted var rawType: String
}

extension FeelingModel {
    convenience init(feeling: Feeling) {
        self.init()

        if feeling.id.count > 0 {
            self._id = feeling.id
        }

        self.rawType = feeling.type.rawValue
    }
}
