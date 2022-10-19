//
//  ExerciseSearchLoader.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 18/10/2022.
//

import Combine
import Foundation

struct ExerciseSearchLoader {
    var urlSession = URLSession.shared
    var userSession: UserSession

    func loadResults(
        matching query: String
    ) -> AnyPublisher<[ExerciseSearch], Error> {
        urlSession.publisher(
            on: .WGERAPIHost,
            for: .search(for: query),
            using: userSession.accessTokenWGER
        )
    }
}
