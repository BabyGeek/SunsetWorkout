//
//  ActivityHIITInput.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/11/2022.
//

import Foundation

struct ActivityHIITInput {
    var id: String = UUID().uuidString
    let round: Int
    let timePassed: Float
    let skipped: Bool
}

// MARK: - init from RealmObject
extension ActivityHIITInput {
    init(object: ActivityHIITInputEntity) {
        self.id = object._id
        self.round = object.round
        self.timePassed = object.timePassed
        self.skipped = object.skipped
    }
}

// MARK: - Identifiable
extension ActivityHIITInput: Identifiable { }

// MARK: - Hashable
extension ActivityHIITInput: Hashable { }
