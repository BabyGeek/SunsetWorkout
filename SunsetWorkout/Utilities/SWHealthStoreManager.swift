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
//            let result = self.checkPermissions()
//
//            switch result {
//            case .success(let success):
//                completion(success)
//            case .failure(let failure):
//                dump(failure)
//                break
//                // Handle auth error
//            }
        })

        self.isWaiting = false
    }

//    func checkPermissions() -> Result<Bool, Error> {
//        No error when not authorized, but if queries have result count to 0 we may say that it is no data or not authorized
//        return .success(true)
//    }
//
//    func sendToAuthorizationSettings() {
//            if let url = URL(string: "App-Prefs:HEALTH&path=SOURCES") {
//                self.dispatchedMainQueue {
//                    UIApplication.shared.open(url)
//                }
//            }
//    }

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
