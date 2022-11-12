//
//  SWActivitySummary.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 05/11/2022.
//

import Foundation
import HealthKit

struct SWActivitySummary {
    var id: String = UUID().uuidString
    let workout: SWWorkout
    let type: SWWorkoutType
    let inputs: [String: [[String: Any]]]
    let startDate: Date
    let endDate: Date
    let duration: TimeInterval
    let totalEnergyBurned: Double
    let events: [HKWorkoutEvent]
    var formattedInputsHIIT: [ActivityHIITInputs] = []
    var formattedInputsStrength: [ActivityStrengthInputs] = []
    
    var date: String {
        let formater = DateFormatter()
        formater.dateStyle = .short
        
        return formater.string(from: startDate)
    }
    
    var startTime: String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: startDate)
        let minutes = calendar.component(.minute, from: startDate) 
        
        return String(format: "%d:%d", hour, minutes)
    }
    
    var title: String {
        String(format: "%@ - %@ - %@", workout.name, date, startTime)
    }
    
    var totalEnergyBurnedQuantity: HKQuantity {
        HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: totalEnergyBurned)
    }
    
    var workoutHK: HKWorkout {
        HKWorkout(
            activityType: type.HKWorkoutActivityType,
            start: startDate,
            end: endDate,
            duration: duration,
            totalEnergyBurned: totalEnergyBurnedQuantity,
            totalDistance: nil,
            metadata: nil)
    }
}

// MARK: - Identifiable
extension SWActivitySummary: Identifiable { }

// MARK: - Equatable
extension SWActivitySummary: Equatable {
    static func == (lhs: SWActivitySummary, rhs: SWActivitySummary) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - init from RealmObject
extension SWActivitySummary {
    init(object: SWActivitySummaryEntity) {
        guard let type = SWWorkoutType(rawValue: object.rawType) else {
            fatalError("Workout type is invalid")
        }
        
        self.id = object._id
        self.workout = SWWorkout(object: object.workout ?? SWWorkoutEntity())
        self.type = type
        self.startDate = object.startDate
        self.endDate = object.endDate
        self.duration = object.duration
        self.totalEnergyBurned = object.totalEnergyBurned
        self.events = []
        self.inputs = [:]
        
        self.formattedInputsHIIT = object.inputsHIIT.map({
            ActivityHIITInputs(object: $0)
        })
        self.formattedInputsStrength = object.inputsStrength.map({
            ActivityStrengthInputs(object: $0)
        })
    }
}
