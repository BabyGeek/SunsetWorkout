//
//  TimeIntervalExtensions.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/11/2022.
//

import Foundation

extension TimeInterval {

    func stringFromTimeInterval() -> String {

        let time = NSInteger(self)

        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)

        if hours > 0 {
            return String(format: "%0.2d:%0.2d:%0.2d", hours, minutes, seconds)
        }

        if minutes > 0 {
            return String(format: "%0.2d:%0.2d", minutes, seconds)
        }

        return String(format: "00:%0.2d", seconds)
    }
}
