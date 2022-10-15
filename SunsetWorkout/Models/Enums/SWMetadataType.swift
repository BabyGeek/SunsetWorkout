//
//  SWMetadataType.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import Foundation

enum SWMetadataType: String {
    case exerciseBreak,
         roundBreak,
         roundNumber,
         serieBreak,
         serieNumber,
         repetitionGoal

    var label: String {
        switch self {
        case .exerciseBreak:
            return NSLocalizedString("metadate.label.exercise.break", comment: "Metadata label")
        case .roundBreak:
            return NSLocalizedString("metadate.label.round.break", comment: "Metadata label")
        case .roundNumber:
            return NSLocalizedString("metadate.label.round.number", comment: "Metadata label")
        case .serieBreak:
            return NSLocalizedString("metadate.label.serie.break", comment: "Metadata label")
        case .serieNumber:
            return NSLocalizedString("metadate.label.serie.number", comment: "Metadata label")
        case .repetitionGoal:
            return NSLocalizedString("metadate.label.repetition.goal", comment: "Metadata label")
        }
    }
}
