//
//  SWError.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/10/2022.
//

import Foundation

struct SWError: Identifiable {
    let id: UUID = UUID()
    let error: Error
}
