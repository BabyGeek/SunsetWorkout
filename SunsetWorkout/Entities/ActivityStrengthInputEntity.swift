//
//  ActivityStrengthInputEntity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/11/2022.
//

import Foundation
import RealmSwift

class ActivityStrengthInputEntity: Object {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var serie: Int
    @Persisted var repetitions: String
    @Persisted var skipped: Bool
}

// MARK: - init from model
extension ActivityStrengthInputEntity {
    convenience init(input: ActivityStrengthInput) {
        self.init()
        
        if input.id.count > 0 {
            self._id = input.id
        }
        
        self.serie = input.serie
        self.repetitions = input.repetitions
        self.skipped = input.skipped
    }
}
