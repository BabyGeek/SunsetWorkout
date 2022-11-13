//
//  ExerciseSearch.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 18/10/2022.
//

import Foundation

struct ExerciseSearch: Identifiable, Codable, Equatable {
    var id: String = UUID().uuidString
    let value: String

    private enum CodingKeys: String, CodingKey { case value }
}
