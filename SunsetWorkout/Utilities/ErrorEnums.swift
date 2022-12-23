//
//  ErrorEnums.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/10/2022.
//
import Foundation

// MARK: - Errors

/// Global app errors
public enum GlobalError: Error {
    case unknown, NaN
}

/// Realm related errors
public enum RealmError: Error {
    case noRealm, failure
}

/// Workouts related errors
public enum SWWorkoutError: Error {
    case noName, isNil, notFound
}

/// Exercises related errors
public enum SWExerciseError: Error {
    case noName, notSaved, severalOrders, isNil
}

/// HealthKit related errors
public enum SWHealthKitError: Error {
    case notSaved, collectionEndFailure
}

// MARK: - Localised Errors
extension GlobalError: LocalizedError {
    public var failureReason: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("error.global.unknown.description", comment: "Error description")
        case .NaN:
            return NSLocalizedString("error.global.NaN.description", comment: "Error description")
        }
    }

    public var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("error.global.unknown.failure.reason", comment: "Error failure reason")
        case .NaN:
            return NSLocalizedString("error.global.NaN.failure.reason", comment: "Error failure reason")
        }
    }
}

extension RealmError: LocalizedError {
    public var failureReason: String? {
        switch self {
        case .noRealm:
            return NSLocalizedString("error.realm.no.realm.description", comment: "Error description")
        case .failure:
            return NSLocalizedString("error.realm.failure.description", comment: "Error description")
        }
    }

    public var errorDescription: String? {
        switch self {
        case .noRealm:
            return NSLocalizedString("error.realm.no.realm.failure.reason", comment: "Error failure reason")
        case .failure:
            return NSLocalizedString("error.realm.failure.failure.reason", comment: "Error failure reason")
        }
    }
}

extension SWWorkoutError: LocalizedError {
    public var failureReason: String? {
        switch self {
        case .noName:
            return NSLocalizedString("error.workout.no.name.description", comment: "Error description")
        case .isNil:
            return NSLocalizedString("error.workout.is.nil.description", comment: "Error description")
        case .notFound:
            return NSLocalizedString("error.workout.not.found.description", comment: "Error description")
        }
    }

    public var errorDescription: String? {
        switch self {
        case .noName:
            return NSLocalizedString("error.workout.no.name.failure.reason", comment: "Error failure reason")
        case .isNil:
            return NSLocalizedString("error.workout.is.nil.failure.reason", comment: "Error failure reason")
        case .notFound:
            return NSLocalizedString("error.workout.not.found.failure.reason", comment: "Error failure reason")
        }
    }
}

extension SWExerciseError: LocalizedError {
    public var failureReason: String? {
        switch self {
        case .noName:
            return NSLocalizedString("error.exercise.no.name.description", comment: "Error description")
        case .notSaved:
            return NSLocalizedString("error.exercise.not.saved.description", comment: "Error description")
        case .severalOrders:
            return NSLocalizedString("error.exercise.several.orders.description", comment: "Error description")
        case .isNil:
            return NSLocalizedString("error.exercise.is.nil.failure.reason", comment: "Error failure reason")
        }
    }

    public var errorDescription: String? {
        switch self {
        case .noName:
            return NSLocalizedString("error.exercise.no.name.failure.reason", comment: "Error failure reason")
        case .notSaved:
            return NSLocalizedString("error.exercise.not.saved.failure.reason", comment: "Error failure reason")
        case .severalOrders:
            return NSLocalizedString("error.exercise.several.orders.failure.reason", comment: "Error failure reason")
        case .isNil:
            return NSLocalizedString("error.exercise.is.nil.failure.reason", comment: "Error failure reason")
        }
    }
}

extension SWHealthKitError: LocalizedError {
    public var failureReason: String? {
        switch self {
        case .notSaved:
            return NSLocalizedString("error.healthkit.not.saved.description", comment: "Error description")
        case .collectionEndFailure:
            return NSLocalizedString("error.healthkit.collection.end.failure.description", comment: "Error description")
        }
    }

    public var errorDescription: String? {
        switch self {
        case .notSaved:
            return NSLocalizedString("error.healthkit.not.saved.failure.reason", comment: "Error failure reason")
        case .collectionEndFailure:
            return NSLocalizedString(
                "error.healthkit.collection.end.failure.failure.reason",
                comment: "Error failure reason")
        }
    }
}
