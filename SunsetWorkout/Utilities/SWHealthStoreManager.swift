//
//  SWHealthStoreManager.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 13/09/2022.
//

import HealthKit

class SWHealthStoreManager: ObservableObject {
    static var shared = SWHealthStoreManager()
    
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
    
    func saveObject<Object: HKWorkout>(_ object: Object, completion: @escaping (_ inner: ThrowableCallback) -> Void) {
        askForPermission { success in
            if success {
                self.store?.save(object, withCompletion: { success, error in
                    if let error {
                        completion({ throw error })
                    }
                    
                    completion({ return success })
                })
            }
        }
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
        if let activeEnergyBurnedQuantityType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned),
           let exerciseQuantityType = HKObjectType.quantityType(forIdentifier: .appleExerciseTime),
           let heightQuantityType = HKObjectType.quantityType(forIdentifier: .height),
           let bodyMassQuantityType = HKObjectType.quantityType(forIdentifier: .bodyMass),
           let sleepAnalysisType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            read = [
                activeEnergyBurnedQuantityType,
                exerciseQuantityType,
                heightQuantityType,
                bodyMassQuantityType,
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
