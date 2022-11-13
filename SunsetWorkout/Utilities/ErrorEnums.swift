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
    case noName, isNil
}

public enum SWExerciseError: Error {
    case noName, notSaved, severalOrders
}

public enum SWHealthKitError: Error {
    case notSaved
}

// MARK: - Localised Errors
extension GlobalError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("error.global.unknown.description", comment: "Error description")
        }
    }

    public var failureReason: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("error.global.unknown.failure.reason", comment: "Error failure reason")
        }
    }
}

extension RealmError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noRealm:
            return NSLocalizedString("error.realm.no.realm.description", comment: "Error description")
        case .failure:
            return NSLocalizedString("error.realm.failure.description", comment: "Error description")
        }
    }

    public var failureReason: String? {
        switch self {
        case .noRealm:
            return NSLocalizedString("error.realm.no.realm.failure.reason", comment: "Error failure reason")
        case .failure:
            return NSLocalizedString("error.realm.failure.failure.reason", comment: "Error failure reason")
        }
    }
}

extension SWWorkoutError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noName:
            return NSLocalizedString("error.workout.no.name.description", comment: "Error description")
        case .isNil:
            return NSLocalizedString("error.workout.is.nil.description", comment: "Error description")
        }
    }

    public var failureReason: String? {
        switch self {
        case .noName:
            return NSLocalizedString("error.workout.no.name.failure.reason", comment: "Error failure reason")
        case .isNil:
            return NSLocalizedString("error.workout.is.nil.failure.reason", comment: "Error failure reason")
        }
    }
}

extension SWExerciseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noName:
            return NSLocalizedString("error.exercise.no.name.description", comment: "Error description")
        case .notSaved:
            return NSLocalizedString("error.exercise.not.saved.description", comment: "Error description")
        case .severalOrders:
            return NSLocalizedString("error.exercise.several.orders.description", comment: "Error description")
        }
    }

    public var failureReason: String? {
        switch self {
        case .noName:
            return NSLocalizedString("error.exercise.no.name.failure.reason", comment: "Error failure reason")
        case .notSaved:
            return NSLocalizedString("error.exercise.not.saved.failure.reason", comment: "Error failure reason")
        case .severalOrders:
            return NSLocalizedString("error.exercise.several.orders.failure.reason", comment: "Error failure reason")
        }
    }
}

extension SWHealthKitError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notSaved:
            return NSLocalizedString("error.healthkit.not.saved.description", comment: "Error description")
        }
    }

    public var failureReason: String? {
        switch self {
        case .notSaved:
            return NSLocalizedString("error.healthkit.not.saved.failure.reason", comment: "Error failure reason")
        }
    }
}
