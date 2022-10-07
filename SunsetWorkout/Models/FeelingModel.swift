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
    @Persisted var rawFeeling: String

    var feeling: Feeling {
        get { return Feeling(rawValue: rawFeeling) ?? Feeling.happy }
        set { rawFeeling = newValue.rawValue }
    }

    convenience init(createdAt: Date, rawFeeling: String) {
        self.init()
        self.created_at = createdAt
        self.rawFeeling = rawFeeling
    }
}
