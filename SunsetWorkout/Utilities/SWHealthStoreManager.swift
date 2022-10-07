//
//  SWHealthStoreManager.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 13/09/2022.
//

import HealthKit

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
        guard let store else {
            completion(false)
            return
        }

        self.isWaiting = true
        self.setToShare()
        self.setRead()

        store.requestAuthorization(toShare: toShare, read: read, completion: { success, _ in
            completion(success)
        })

        self.isWaiting = false
    }

    private func setToShare() {
        let workoutType = HKSampleType.workoutType()

        if let heightQuantityType = HKQuantityType.quantityType(forIdentifier: .height),
           let bodyMassQuantityType = HKQuantityType.quantityType(forIdentifier: .bodyMass) {
            toShare = [
                workoutType,
                heightQuantityType,
                bodyMassQuantityType
            ]
        }
    }

    private func setRead() {
        let activitySummaryType = HKObjectType.activitySummaryType()

        if let heartRateQuantityType = HKObjectType.quantityType(forIdentifier: .heartRate),
           let activeEnergyBurnedQuantityType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
           let basalEnergyBurnedQuantityType = HKObjectType.quantityType(forIdentifier: .basalEnergyBurned),
           let restingHeartRateQuantityType = HKObjectType.quantityType(forIdentifier: .restingHeartRate),
           let standUpQuantityType = HKObjectType.quantityType(forIdentifier: .appleStandTime),
           let exerciceQuantityType = HKObjectType.quantityType(forIdentifier: .appleExerciseTime),
           let heightQuantityType = HKObjectType.quantityType(forIdentifier: .height),
           let bodyMassQuantityType = HKObjectType.quantityType(forIdentifier: .bodyMass),
           let userDateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth),
           let userBiologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex),
           let sleepAnalysisType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
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
                userBiologicalSex,
                sleepAnalysisType
            ]
        }
    }

    func dispatchedMainQueue(_ completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            completion()
        }
    }
}
