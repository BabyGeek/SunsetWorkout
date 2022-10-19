//
//  URLSessionExtensions.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 18/10/2022.
//

import Combine
import Foundation

extension URLSession {
    func publisher<K, R>(
            on APIHost: APIHost,
            for endpoint: Endpoint<K, R>,
            using requestData: K.RequestData,
            decoder: JSONDecoder = .init()
        ) -> AnyPublisher<R, Error> {
            guard let request = endpoint.makeRequest(on: APIHost, with: requestData) else {
                return Fail(
                    error: InvalidEndpointError(endpoint: endpoint)
                ).eraseToAnyPublisher()
            }

            return dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: NetworkResponse<R>.self, decoder: decoder)
                .map(\.suggestions)
                .eraseToAnyPublisher()
        }
}
