//
//  SWWorkoutType.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import HealthKit

enum SWWorkoutType: String {
    case highIntensityIntervalTraining = "HIIT"
    case traditionalStrengthTraining = "Strenght"

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
            return [.exerciseBreak, .roundBreak, .roundNumber]
        case .traditionalStrengthTraining:
            return [.exerciseBreak, .serieBreak, .serieNumber, .repetitionGoal]
        }
    }
}
