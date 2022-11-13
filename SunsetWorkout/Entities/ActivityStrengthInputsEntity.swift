//
//  ActivityStrengthInputsEntity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/11/2022.
//

import Foundation
import RealmSwift

class ActivityStrengthInputsEntity: Object {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var exerciseUUID: String = ""
    @Persisted var exerciseOrder: Int = 0
    @Persisted var inputs = List<ActivityStrengthInputEntity>()
}

// MARK: - init from model
extension ActivityStrengthInputsEntity {
    convenience init(input: ActivityStrengthInputs) {
        self.init()

        if input.id.count > 0 {
            self._id = input.id
        }

        self.exerciseUUID = input.exerciseUUID
        self.exerciseOrder = input.exerciseOrder
        self.inputs.append(objectsIn: input.inputs.map({
            ActivityStrengthInputEntity(input: $0)
            }))
    }
}
