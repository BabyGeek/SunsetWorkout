//
//  WGERNetworkResponse.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 18/10/2022.
//

struct WGERNetworkResponse<Wrapped: Decodable>: Decodable {
    var suggestions: Wrapped
}
