//
//  ProfileConfigurationViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 15/09/2022.
//

import HealthKit

class ProfileConfigurationViewModel: SWHealthStoreManager, HKQueriable {
    typealias QueryType = HKSampleQuery
    var query: HKSampleQuery?

    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var age: String = ""

    private var currentWeight: String = ""
    private var currentHeight: String = ""

    init(query: HKSampleQuery? = nil) {
        super.init()
        self.query = query
        self.refreshValues()
    }

    func refreshValues() {
        self.askForPermission { success in
            if success {
                self.getHeight()
                self.getWeight()
                self.getGender()
            }
        }
    }

    func saveValues() {
        self.askForPermission { success in
            if success {
                // TODO ONLY IF VALUES CHANGED TO AVOID MANY SAVINGS IF USER NAVIGATES
                // SHOULD WE SAVE AGE? AS WE DETERMINE IT FROM BIRTHDATE?
                self.saveWeight()
                self.saveHeight()
            }
        }
    }

    func getUserLocaleHeightUnit() -> String {
        var unitHeight = "feet"

        if Locale.current.usesMetricSystem {
            unitHeight = "meters"
        }

        return unitHeight
    }

    func getUserLocaleWeightUnit() -> String {
        var unitWeight = "pounds"

        if Locale.current.usesMetricSystem {
            unitWeight = "kg"
        }

        return unitWeight
    }

    private func determineAge() {
        if let dateOfBirthComponent = try? store?.dateOfBirthComponents() {
            DispatchQueue.main.async {
                self.age = String(
                    format: "%d",
                    Calendar.current.component(.year, from: Date()) - (dateOfBirthComponent.year ?? 0))
            }
        }
    }

    private func getGender() {
        if let sexe = try? store?.biologicalSex().biologicalSex.rawValue {
            dump(HKBiologicalSex(rawValue: sexe))

        }
    }

    private func getHeight() {
        if let heightQuantityType = HKQuantityType.quantityType(forIdentifier: .height) {
            query = HKSampleQuery(
                sampleType: heightQuantityType,
                predicate: nil,
                limit: 0,
                sortDescriptors: nil,
                resultsHandler: { _, samples, _ in
                    if let userHeightSample = samples?.last as? HKQuantitySample {
                        var unit = HKUnit.foot()
                        if Locale.current.usesMetricSystem {
                            unit = .meter()
                        }

                        DispatchQueue.main.async {
                            self.height = String(format: "%.2f", userHeightSample.quantity.doubleValue(for: unit))
                            self.currentHeight = self.height
                        }
                    }
                })
        }
        executeQuery()
    }

    private func getWeight() {
        if let bodyMassQuantityType = HKQuantityType.quantityType(forIdentifier: .bodyMass) {
            query = HKSampleQuery(
                sampleType: bodyMassQuantityType,
                predicate: nil,
                limit: 0,
                sortDescriptors: nil,
                resultsHandler: { _, samples, _ in
                    if let userWeightSample = samples?.last as? HKQuantitySample {
                        var unit = HKUnit.pound()
                        if Locale.current.usesMetricSystem {
                            unit = .gramUnit(with: .kilo)
                        }

                        DispatchQueue.main.async {
                            self.weight = String(format: "%.2f", userWeightSample.quantity.doubleValue(for: unit))
                            self.currentWeight = self.weight
                        }
                    }
                })
        }
        executeQuery()
    }

    private func saveHeight() {
        if self.height == self.currentHeight {
            return
        }

        if let heightQuantityType = HKQuantityType.quantityType(forIdentifier: .height),
           let value = Double(height) {

            var unit = HKUnit.foot()
            if Locale.current.usesMetricSystem {
                unit = .meter()
            }

            let heightSample = HKQuantitySample(
                type: heightQuantityType,
                quantity: HKQuantity(unit: unit, doubleValue: value),
                start: Date(),
                end: Date())

            store?.save(heightSample) { _, error in
                if error != nil {
                    dump("error")
                }
            }
        }
    }

    private func saveWeight() {
        if self.weight == self.currentWeight {
            return
        }

        let bodyMassQuantityType = HKQuantityType.quantityType(forIdentifier: .bodyMass)

        if let bodyMassQuantityType,
           let value = Double(weight) {

            var unit = HKUnit.pound()
            if Locale.current.usesMetricSystem {
                unit = .gramUnit(with: .kilo)
            }

            let weightSample = HKQuantitySample(
                type: bodyMassQuantityType,
                quantity: HKQuantity(unit: unit, doubleValue: value),
                start: Date(),
                end: Date())

            store?.save(weightSample) { _, error in
                if error != nil {
                    dump("error")
                }
            }
        }
    }

    func executeQuery() {
        if let query = query {
            store?.execute(query)
        }
    }
}
