//
//  ToasterPosition.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 27/11/2022.
//

import SwiftUI

enum ToasterPosition {
    case top, bottom

    var edgeMoving: Edge {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        }
    }
}
