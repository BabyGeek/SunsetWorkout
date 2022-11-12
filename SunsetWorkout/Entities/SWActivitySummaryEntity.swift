//
//  SWActivitySummaryEntity.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/11/2022.
//

import Foundation
import RealmSwift

class SWActivitySummaryEntity: Object {
    @Persisted(primaryKey: true) var _id: String = UUID().uuidString
    @Persisted var created_at = Date()
    @Persisted var rawType: String
    @Persisted var workout: SWWorkoutEntity?
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var duration: Double
    @Persisted var totalEnergyBurned: Double
    @Persisted var inputsHIIT = List<ActivityHIITInputsEntity>()
    @Persisted var inputsStrength = List<ActivityStrengthInputsEntity>()
}

// MARK: - init from model
extension SWActivitySummaryEntity {
    convenience init(summary: SWActivitySummary) {
        self.init()

        if summary.id.count > 0 {
            self._id = summary.id
        }
        
        self.created_at = summary.startDate
        self.rawType = summary.type.rawValue
        self.workout = SWWorkoutEntity(workout: summary.workout)
        self.startDate = summary.startDate
        self.endDate = summary.endDate
        self.duration = summary.duration
        self.totalEnergyBurned = summary.totalEnergyBurned
        self.setUpInputs(with: summary)
    }
    
    func setUpInputs(with summary: SWActivitySummary) {
        if summary.type == .highIntensityIntervalTraining {
            self.setUpHIITInputs(with: summary)
        } else if summary.type == .traditionalStrengthTraining {
            self.setUpStrengthInputs(with: summary)
        }
    }
    
    private func setUpHIITInputs(with summary: SWActivitySummary) {
        for (id, values) in summary.inputs {
            let actityInputs = ActivityHIITInputsEntity()
            actityInputs.exerciseUUID = id
            
            for input in values {
                let hiitInput = ActivityHIITInputEntity()
                hiitInput.skipped = false
                for (key, value) in input {
                    if key == "currentRepetition" {
                        if let value = value as? Int {
                            hiitInput.round = value
                        }
                    }
                    
                    if key == "value" {
                        if let value = value as? Int {
                            hiitInput.timePassed = value
                        }
                    }
                    
                    if key == "skipped" {
                        if let value = value as? Bool {
                            hiitInput.skipped = value
                        }
                    }
                }
                
                actityInputs.inputs.append(hiitInput)
            }
            
            self.inputsHIIT.append(actityInputs)
        }
    }
    
    private func setUpStrengthInputs(with summary: SWActivitySummary) {
        for (id, values) in summary.inputs {
            let actityInputs = ActivityStrengthInputsEntity()
            actityInputs.exerciseUUID = id
            
            for input in values {
                let strengthInput = ActivityStrengthInputEntity()
                strengthInput.skipped = false
                for (key, value) in input {
                    if key == "currentRepetition" {
                        if let value = value as? Int {
                            strengthInput.serie = value
                        }
                    }
                    
                    if key == "value" {
                        if let value = value as? String {
                            strengthInput.repetitions = value
                        }
                    }
                    
                    if key == "skipped" {
                        if let value = value as? Bool {
                            strengthInput.skipped = value
                        }
                    }
                }
                
                actityInputs.inputs.append(strengthInput)
            }
            
            self.inputsStrength.append(actityInputs)
        }
    }
}
