//
//  NetworkResponse.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 18/10/2022.
//

struct NetworkResponse<Wrapped: Decodable>: Decodable {
    var suggestions: Wrapped
}
