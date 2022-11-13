//
//  InvalidEndpointError.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 19/10/2022.
//

struct InvalidEndpointError<K: EndpointKind, R: Decodable>: Error {
    let endpoint: Endpoint<K, R>
}
