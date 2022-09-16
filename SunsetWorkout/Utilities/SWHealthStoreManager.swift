//
//  SWHealthStoreManager.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 13/09/2022.
//

import HealthKit

protocol HKQueriable {
    associatedtype QueryType: HKQuery
    var query: QueryType? { get set }

    func executeQuery()
}

class SWHealthStoreManager: ObservableObject {
    private var toShare: Set<HKSampleType>?
    private var read: Set<HKObjectType>?
    var store: HKHealthStore?
    var isWaiting: Bool = false

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            store = HKHealthStore()
        }
    }

    func askForPermission(completion: @escaping (Bool) -> Void) {
        self.isWaiting = true
        self.setToShare()
        self.setRead()

        store?.requestAuthorization(toShare: toShare, read: read, completion: { success, _ in
            completion(success)
        })

        self.isWaiting = false
    }

    private func setToShare() {
        let workoutType = HKSampleType.workoutType()
        let heightQuantityType = HKQuantityType.quantityType(forIdentifier: .height)
        let bodyMassQuantityType = HKQuantityType.quantityType(forIdentifier: .bodyMass)

        if let heightQuantityType,
           let bodyMassQuantityType {
            toShare = [
                workoutType,
                heightQuantityType,
                bodyMassQuantityType
            ]
        }
    }

    private func setRead() {
        let activitySummaryType = HKActivitySummaryType.activitySummaryType()
        let heartRateQuantityType = HKQuantityType.quantityType(forIdentifier: .heartRate)
        let activeEnergyBurnedQuantityType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)
        let basalEnergyBurnedQuantityType = HKQuantityType.quantityType(forIdentifier: .basalEnergyBurned)
        let restingHeartRateQuantityType = HKQuantityType.quantityType(forIdentifier: .restingHeartRate)
        let standUpQuantityType = HKQuantityType.quantityType(forIdentifier: .appleStandTime)
        let exerciceQuantityType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime)
        let heightQuantityType = HKQuantityType.quantityType(forIdentifier: .height)
        let bodyMassQuantityType = HKQuantityType.quantityType(forIdentifier: .bodyMass)
        let userDateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth)
        let userBiologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex)

        if let heartRateQuantityType,
           let activeEnergyBurnedQuantityType,
           let basalEnergyBurnedQuantityType,
           let restingHeartRateQuantityType,
           let standUpQuantityType,
           let exerciceQuantityType,
           let heightQuantityType,
           let bodyMassQuantityType,
           let userDateOfBirth,
           let userBiologicalSex {
            read = [
                activitySummaryType,
                heartRateQuantityType,
                activeEnergyBurnedQuantityType,
                activitySummaryType,
                basalEnergyBurnedQuantityType,
                restingHeartRateQuantityType,
                standUpQuantityType,
                exerciceQuantityType,
                heightQuantityType,
                bodyMassQuantityType,
                userDateOfBirth,
                userBiologicalSex
            ]
        }
    }
}
