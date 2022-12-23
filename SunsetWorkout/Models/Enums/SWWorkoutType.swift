//
//  SWWorkoutType.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import Foundation
import HealthKit

enum SWWorkoutType: String, CaseIterable {
    case highIntensityIntervalTraining, traditionalStrengthTraining, mixed, cycle

    var name: String {
        switch self {
        case .highIntensityIntervalTraining:
            return NSLocalizedString("workout.type.name.hiit", comment: "HIIT workout type")
        case .traditionalStrengthTraining:
            return NSLocalizedString("workout.type.name.strenght", comment: "Strenght workout type")
        case .mixed:
            return NSLocalizedString("workout.type.name.mixed", comment: "Mixed workout type")
        case .cycle:
            return NSLocalizedString("workout.type.name.cycle", comment: "Cycle workout type")
        }
    }

    var HKWorkoutActivityType: HKWorkoutActivityType {
        switch self {
        case .highIntensityIntervalTraining, .cycle:
            return .highIntensityIntervalTraining
        case .traditionalStrengthTraining, .mixed:
            return .traditionalStrengthTraining
        }
    }

    var SWMetadataTypes: [SWMetadataType] {
        switch self {
        case .highIntensityIntervalTraining, .cycle:
            return [.exerciseBreak, .roundBreak, .roundNumber, .roundDuration]
        case .traditionalStrengthTraining:
            return [.exerciseBreak, .serieBreak, .serieNumber, .repetitionGoal]
        case .mixed:
            return [.exerciseBreak, .roundBreak, .roundNumber, .roundDuration, .serieBreak, .serieNumber, .repetitionGoal]
        }
    }

    var MET: Double {
        switch self {
        case .highIntensityIntervalTraining, .cycle:
            return 8
        case .traditionalStrengthTraining:
            return 3.8
        case .mixed:
            return 5.9
        }
    }
    
    var iconName: String {
        switch self {
        case .highIntensityIntervalTraining:
            if #available(iOS 16, *) {
                return "figure.highintensity.intervaltraining"
            } else {
                return "bolt.heart"
            }
        case .traditionalStrengthTraining:
            if #available(iOS 16, *) {
                return "figure.strengthtraining.traditional"
            } else {
                return "list.bullet.clipboard"
            }
        case .mixed:
            if #available(iOS 16, *) {
                return "figure.mixed.cardio"
            } else {
                return "custom.figure.strengthtraining.traditional"
            }
        case .cycle:
            return "arrow.triangle.2.circlepath"
        }
    }
    
    var repetitionLabel: String {
        switch self {
        case .highIntensityIntervalTraining:
            return NSLocalizedString("workout.hiit.repetition", comment: "Workout HIIT repetition name")
        case .traditionalStrengthTraining:
            return NSLocalizedString("workout.strength.repetition", comment: "Workout Strength repetition name")
        case .mixed:
            return NSLocalizedString("workout.mixed.repetition", comment: "Workout mixed repetition name")
        case .cycle:
            return NSLocalizedString("workout.cycle.repetition", comment: "Workout cycle repetition name")
        }
    }
}
