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
    
    var title: String {
        if let error = error as? LocalizedError {
            if let failureReason = error.failureReason {
                return failureReason
            }
        }

        return GlobalError.unknown.failureReason!
    }

    var description: String {
        return error.localizedDescription
    }
}

extension SWError: Equatable {
    static func == (lhs: SWError, rhs: SWError) -> Bool {
        lhs.id == rhs.id
    }
}
