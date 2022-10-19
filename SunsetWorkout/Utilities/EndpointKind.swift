//
//  EndpointKind.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 18/10/2022.
//

import Foundation

protocol EndpointKind {
    associatedtype RequestData

    static func prepare(_ request: inout URLRequest,
                        with data: RequestData)
}
