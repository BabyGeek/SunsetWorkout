//
//  SWWorkoutType.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import Foundation
import HealthKit

enum SWWorkoutType: String {
    case highIntensityIntervalTraining, traditionalStrengthTraining

    var name: String {
        switch self {
        case .highIntensityIntervalTraining:
            return NSLocalizedString("workout.type.name.hiit", comment: "HIIT workout type")
        case .traditionalStrengthTraining:
            return NSLocalizedString("workout.type.name.strenght", comment: "Strenght workout type")
        }
    }

    var HKWorkoutActivityType: HKWorkoutActivityType {
        switch self {
        case .highIntensityIntervalTraining:
            return .highIntensityIntervalTraining
        case .traditionalStrengthTraining:
            return .traditionalStrengthTraining
        }
    }

    var SWMetadataTypes: [SWMetadataType] {
        switch self {
        case .highIntensityIntervalTraining:
            return [.exerciseBreak, .roundBreak, .roundNumber, .roundDuration]
        case .traditionalStrengthTraining:
            return [.exerciseBreak, .serieBreak, .serieNumber, .repetitionGoal]
        }
    }

    var MET: Double {
        switch self {
        case .highIntensityIntervalTraining:
            return 8
        case .traditionalStrengthTraining:
            return 3.8
        }
    }
}
