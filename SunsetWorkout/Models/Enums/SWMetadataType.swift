//
//  SWMetadataType.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import SwiftUI

enum SWMetadataType: String {
    case exerciseBreak,
         roundBreak,
         roundNumber,
         roundDuration,
         serieBreak,
         serieNumber,
         repetitionGoal

    var label: LocalizedStringKey {
        switch self {
        case .exerciseBreak:
            return "metadate.label.exercise.break"
        case .roundBreak:
            return "metadate.label.round.break"
        case .roundNumber:
            return "metadate.label.round.number"
        case .roundDuration:
            return "metadate.label.round.duration"
        case .serieBreak:
            return "metadate.label.serie.break"
        case .serieNumber:
            return "metadate.label.serie.number"
        case .repetitionGoal:
            return "metadate.label.repetition.goal"
        }
    }
    
    var iconName: String {
        switch self {
        case .exerciseBreak:
            return "exclamationmark.arrow.circlepath"
        case .roundBreak, .serieBreak:
            return "goforward"
        case .roundDuration:
            return "clock.arrow.2.circlepath"
        case .serieNumber, .roundNumber:
            return "number"
        case .repetitionGoal:
            return "repeat"
        }
    }
}
