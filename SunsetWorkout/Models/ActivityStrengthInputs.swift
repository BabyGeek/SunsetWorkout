//
//  ActivityStrengthInputs.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/11/2022.
//

import Foundation

struct ActivityStrengthInputs {
    var id: String = UUID().uuidString
    let exerciseUUID: String
    let exerciseOrder: Int
    let inputs: [ActivityStrengthInput]
}

// MARK: - init from RealmObject
extension ActivityStrengthInputs {
    init(object: ActivityStrengthInputsEntity) {
        self.id = object._id
        self.exerciseUUID = object.exerciseUUID
        self.exerciseOrder = object.exerciseOrder
        self.inputs = object.inputs.map({
            ActivityStrengthInput(object: $0)})
    }
}

// MARK: - Identifiable
extension ActivityStrengthInputs: Identifiable { }

// MARK: - Hashable
extension ActivityStrengthInputs: Hashable { }
