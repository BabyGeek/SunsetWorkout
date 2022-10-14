//
//  ErrorEnums.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/10/2022.
//
import Foundation

// MARK: - Errors
public enum GlobalError: Error {
    case unknown
}

public enum RealmError: Error {
    case noRealm, failure
}

public enum SWWorkoutError: Error {
    case noName
}

// MARK: - Localised Errors
extension GlobalError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .unknown:
            return "An unknown error occured."
        }
    }
}

extension RealmError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noRealm:
            return "Realm error"
        case .failure:
            return "Fail"
        }
    }

    public var failureReason: String? {
        switch self {
        case .noRealm:
            return "Realm was not able to be found."
        case .failure:
            return "A failure occured while saving or fetching data."
        }
    }
}

extension SWWorkoutError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noName:
            return "Workout error"
        }
    }

    public var failureReason: String? {
        switch self {
        case .noName:
            return "You need to specify a name for the workout."
        }
    }
}
