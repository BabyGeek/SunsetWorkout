//
//  Endpoint.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 18/10/2022.
//

import Foundation

struct Endpoint<Kind: EndpointKind, Response: Decodable> {
    var path: String
    var queryItems = [URLQueryItem]()
}

extension Endpoint {
    func makeRequest(on api: APIHost, with data: Kind.RequestData) -> URLRequest? {
        var components = URLComponents()
        components.scheme = api.scheme
        components.host = api.host
        components.path = "/api/v2/" + path
        components.queryItems = queryItems.isEmpty ? nil : queryItems

        // If either the path or the query items passed contained
        // invalid characters, we'll get a nil URL back:
        guard let url = components.url else {
            return nil
        }

        var request = URLRequest(url: url)
        Kind.prepare(&request, with: data)
        return request
    }
}

extension Endpoint where Kind == EndpointKinds.Private, Response == [ExerciseSearch] {
    static func search(for query: String) -> Self {
        Endpoint(path: "exercise/search", queryItems: [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "term", value: query)
        ])
    }
}
