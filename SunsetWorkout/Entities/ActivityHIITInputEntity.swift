//
//  ActivityHIITInputEntity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/11/2022.
//

import Foundation
import RealmSwift

class ActivityHIITInputEntity: Object {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var round: Int
    @Persisted var timePassed: Float
    @Persisted var skipped: Bool
}

// MARK: - init from model
extension ActivityHIITInputEntity {
    convenience init(input: ActivityHIITInput) {
        self.init()

        if input.id.count > 0 {
            self._id = input.id
        }

        self.round = input.round
        self.timePassed = input.timePassed
        self.skipped = input.skipped
    }
}
