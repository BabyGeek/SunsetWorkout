//
//  APIHost.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 18/10/2022.
//

import Foundation

struct APIHost {
    let scheme: String
    let host: String
}

extension APIHost {
    static var WGERAPIHost = APIHost(scheme: "https", host: "wger.de")
}
