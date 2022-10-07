//
//  ErrorEnums.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/10/2022.
//
import Foundation

public enum RealmError: Error {
    case noRealm, failure, unknown
}

extension RealmError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noRealm:
            return "Realm error"
        case .failure:
            return "Fail"
        case .unknown:
            return "Unknown error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .noRealm:
            return "Realm was not able to be found."
        case .failure:
            return "A failure occured while saving or fetching data."
        case .unknown:
            return "An unknown error occured"
        }
    }
}
