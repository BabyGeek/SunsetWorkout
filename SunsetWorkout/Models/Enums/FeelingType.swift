//
//  FeelingType.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import Foundation

enum FeelingType: String, CaseIterable {
    case happy, sad, annoyed, excited, tired, stressed

    var shortName: String {
        switch self {
        case .happy:
            return NSLocalizedString("feeling.name.happy", comment: "Happy feeling short name")
        case .sad:
            return NSLocalizedString("feeling.name.sad", comment: "Sad feeling short name")
        case .annoyed:
            return NSLocalizedString("feeling.name.annoyed", comment: "Annoyed feeling short name")
        case .excited:
            return NSLocalizedString("feeling.name.excited", comment: "Excited feeling short name")
        case .tired:
            return NSLocalizedString("feeling.name.tired", comment: "Tired feeling short name")
        case .stressed:
            return NSLocalizedString("feeling.name.stressed", comment: "Stressed feeling short name")
        }
    }

    var relatedEmoji: String {
        switch self {
        case .happy:
            return "😃"
        case .sad:
            return "😔"
        case .annoyed:
            return "😒"
        case .excited:
            return "😛"
        case .tired:
            return "😴"
        case .stressed:
            return "😰"
        }
    }

    var relatedDescription: String {
        switch self {
        case .happy:
            return NSLocalizedString("feeling.description.happy", comment: "Happy feeling description")
        case .sad:
            return NSLocalizedString("feeling.description.sad", comment: "Sad feeling description")
        case .annoyed:
            return NSLocalizedString("feeling.description.annoyed", comment: "Annoyed feeling description")
        case .excited:
            return NSLocalizedString("feeling.description.excited", comment: "Excited feeling description")
        case .tired:
            return NSLocalizedString("feeling.description.tired", comment: "Tired feeling description")
        case .stressed:
            return NSLocalizedString("feeling.description.stressed", comment: "Stressed feeling description")
        }
    }
}
