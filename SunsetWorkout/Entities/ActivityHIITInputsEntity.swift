//
//  ActivityHIITInputsEntity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/11/2022.
//

import Foundation
import RealmSwift

class ActivityHIITInputsEntity: Object {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var exerciseUUID: String = ""
    @Persisted var inputs = List<ActivityHIITInputEntity>()
}

// MARK: - init from model
extension ActivityHIITInputsEntity {
    convenience init(inputs: ActivityHIITInputs) {
        self.init()
        
        if inputs.id.count > 0 {
            self._id = inputs.id
        }
        
        self.exerciseUUID = inputs.exerciseUUID
        self.inputs.append(objectsIn: inputs.inputs.map({
                ActivityHIITInputEntity(input: $0)
            }))
    }
}
