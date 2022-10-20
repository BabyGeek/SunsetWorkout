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

    var description: String {
        if let error = error as? LocalizedError {
            if let description = error.errorDescription {
                return description
            }
        }

        return GlobalError.unknown.errorDescription!
    }

    var failureReason: String {
        if let error = error as? LocalizedError {
            if let failureReason = error.failureReason {
                return failureReason
            }
        }

        return GlobalError.unknown.failureReason!
    }
}
