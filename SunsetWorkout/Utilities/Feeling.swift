//
//  Feeling.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import Foundation

enum Feeling: String, CaseIterable {
    case happy, sad, annoyed, excited, tired, stressed

    var shortName: String {
        switch self {
        case .happy:
            return "Happy"
        case .sad:
            return "Sad"
        case .annoyed:
            return "Annoyed"
        case .excited:
            return "Excited"
        case .tired:
            return "Tired"
        case .stressed:
            return "Stressed"
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
            return "I'm feeling happy!"
        case .sad:
            return "I'm sad :("
        case .annoyed:
            return "I'm annoyed."
        case .excited:
            return "I'm feeling so excited!"
        case .tired:
            return "I'm tired."
        case .stressed:
            return "I'm feeling so stressed."
        }
    }
}
