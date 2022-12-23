//
//  ToasterType.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 27/11/2022.
//

import SwiftUI

enum ToasterType {
    case error, success, warning, info

    var iconName: String {
        switch self {
        case .error:
            return "xmark.circle.fill"
        case .success:
            return "checkmark.circle.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .info:
            return "info.circle.fill"
        }
    }

    var foregroundColor: Color {
        switch self {
        case .error:
            return .red
        case .success:
            return .green
        case .warning:
            return .yellow
        case .info:
            return .blue
        }
    }
}
