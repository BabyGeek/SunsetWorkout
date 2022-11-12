//
//  ActivityHIITInputs.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/11/2022.
//

import Foundation

struct ActivityHIITInputs {
    var id: String = UUID().uuidString
    let exerciseUUID: String
    let inputs: [ActivityHIITInput]
}

// MARK: - init from RealmObject
extension ActivityHIITInputs {
    init(object: ActivityHIITInputsEntity) {
        self.id = object._id
        self.exerciseUUID = object.exerciseUUID
        self.inputs = object.inputs.map({
            ActivityHIITInput(object: $0)})
    }
}
