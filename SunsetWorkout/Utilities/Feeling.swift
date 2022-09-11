//
//  Feeling.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import Foundation

enum Feeling: CaseIterable {
    case happy, sad, annoyed, excited, tired, stressed

    var relatedEmoji: String {
        switch self {
        case .happy:
            return "😃"
        case .sad:
            return "😔"
        case .annoyed:
            return "😒"
        case .excited:
            return "🤪"
        case .tired:
            return "😴"
        case .stressed:
            return "😰"
        }
    }

    var relatedDescription: String {
        switch self {
        case .happy:
            return "You're feeling happy today. That's great, continue in that way."
        case .sad:
            return "You're feeling sad, everything gonne be ok."
        case .annoyed:
            return "You're feeling annoyed."
        case .excited:
            return "You're feeling very excited today ! That's great for your workouts."
        case .tired:
            return "You're feeling tired. Maybe you need some break?"
        case .stressed:
            return "You're feeling stressed, you should try to get this stress away."
        }
    }
}
