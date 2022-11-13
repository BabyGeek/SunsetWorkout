//
//  ActivityStrengthInput.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/11/2022.
//

import Foundation

struct ActivityStrengthInput {
    var id: String = UUID().uuidString
    let serie: Int
    let repetitions: String
    let skipped: Bool
}

// MARK: - init from RealmObject
extension ActivityStrengthInput {
    init(object: ActivityStrengthInputEntity) {
        self.id = object._id
        self.serie = object.serie
        self.repetitions = object.repetitions
        self.skipped = object.skipped
    }
}

// MARK: - Identifiable
extension ActivityStrengthInput: Identifiable { }

// MARK: - Hashable
extension ActivityStrengthInput: Hashable { }
