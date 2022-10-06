//
//  DateExtension.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/10/2022.
//
import Foundation

// MARK: - Date extension for getDay method depending on order and type
extension Date {
    enum DayOrder {
        case before, after
    }

    enum DayType {
        case morning, noon, evening
    }

    func getDay(order: DayOrder, type: DayType) -> Date {
        switch type {
        case .morning:
            if order == .before {
                return Date().morningBefore
            } else {
                return Date().morningAfter
            }
        case .noon:
            if order == .before {
                return Date().noonBefore
            } else {
                return Date().noonAfter
            }
        case .evening:
            if order == .before {
                return Date().eveningBefore
            } else {
                return Date().eveningAfter
            }
        }
    }
}

// MARK: - Date extension for day times setup
extension Date {
    var morning: Date {
        return Calendar.current.date(bySettingHour: 6, minute: 0, second: 0, of: self)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var evening: Date {
        return Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: self)!
    }
}

// MARK: - Date extension to add variables from Calendar depending on day time
extension Date {
    var morningBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: morning)!
    }
    var morningAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: morning)!
    }

    var noonBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var noonAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }

    var eveningBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: evening)!
    }
    var eveningAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: evening)!
    }
}
