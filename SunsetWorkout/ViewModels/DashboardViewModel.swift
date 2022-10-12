//
//  DashboardViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/09/2022.
//

import HealthKit

class DashboardViewModel: SWHealthStoreManager {
    var feelingViewModel = FeelingViewModel()
    @Published var quote: Quote?
    @Published var feeling: FeelingModel?
    @Published var sleptHours: HKQuantity = HKQuantity(unit: .second(), doubleValue: 0)
    @Published var dailyKilocalories: HKQuantity = HKQuantity(unit: .kilocalorie(), doubleValue: 0)
    @Published var dailyTrainedTime: HKQuantity = HKQuantity(unit: .minute(), doubleValue: 0)

    func getUpdatedValues() {
        self.askForPermission { success in
            if success {
                self.getDailyQuote()
                self.getSleptHours()
                self.getMovedCalories()
                self.getTrainedTime()
                self.getFeeling()
            }
        }
    }

    func getDailyQuote() {
        self.dispatchedMainQueue {
            self.quote = Quote(
                author: "Jhon Doe",
                content: "Lorem ipsum dolor sit amet, " +
                "consectetuer adipiscing elit. Aenean commodo ligula eget dolor. " +
                "Aenean massa. Cum sociis natoq",
                tags: ["sports", "competition"])
        }
    }

    func getSleptHours() {
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

            // predicate
            let predicate = HKSampleQuery.predicateForSamples(
                withStart: Date().getDay(order: .before, type: .evening),
                end: Date(),
                options: [.strictStartDate, .strictEndDate])

            print("Start at: \(Date().getDay(order: .before, type: .evening))")
            print("End at: \(Date())")

            // the block completion to execute
            let query = HKSampleQuery(
                sampleType: sleepType,
                predicate: predicate,
                limit: 0,
                sortDescriptors: [sortDescriptor]) { (_, tmpResult, error) -> Void in
                if error != nil {
                    // Handle the error in your app gracefully
                    dump(error)
                    return
                }

                if let result = tmpResult {
                    var sleptTimeTotal: Double = 0

                    for item in result {

                        if let sample = item as? HKCategorySample {
                            print("start at: \(sample.startDate), end at: \(sample.endDate), time difference: \(sample.endDate.timeIntervalSince(sample.startDate))")
                            sleptTimeTotal += sample.endDate.timeIntervalSince(sample.startDate)
                        }
                    }

                    self.dispatchedMainQueue {
                        self.sleptHours = HKQuantity(unit: .second(), doubleValue: sleptTimeTotal)
                    }
                }
            }
            store?.execute(query)
        }
    }

    func getMovedCalories() {
        if let activeEnergyBurnedType = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) {

            let sortDescriptor = NSSortDescriptor(
                key: HKSampleSortIdentifierEndDate,
                ascending: false)

            let predicate = HKSampleQuery.predicateForSamples(
                withStart: Calendar.current.startOfDay(for: Date()),
                end: Date())

            let query = HKSampleQuery(
                sampleType: activeEnergyBurnedType,
                predicate: predicate,
                limit: 0,
                sortDescriptors: [sortDescriptor]) { (_, tmpResult, error) in
                    if error != nil {
                        dump("error")
                    }

                    if let results = tmpResult as? [HKQuantitySample] {
                        let totalKilocalories = self.extractFrom(results, unit: .kilocalorie())

                        self.dispatchedMainQueue {
                            self.dailyKilocalories = HKQuantity(unit: .kilocalorie(), doubleValue: totalKilocalories)
                        }
                    }
                }

            store?.execute(query)
        }
    }

    func getTrainedTime() {
        if let appleExerciseTimeType = HKObjectType.quantityType(forIdentifier: .appleExerciseTime) {

            let sortDescriptor = NSSortDescriptor(
                key: HKSampleSortIdentifierEndDate,
                ascending: false)

            let predicate = HKSampleQuery.predicateForSamples(
                withStart: Calendar.current.startOfDay(for: Date()),
                end: Date())

            let query = HKSampleQuery(
                sampleType: appleExerciseTimeType,
                predicate: predicate,
                limit: 0,
                sortDescriptors: [sortDescriptor]) { (_, tmpResult, error) in
                    if error != nil {
                        dump("error")
                    }

                    if let results = tmpResult as? [HKQuantitySample] {
                        let totalExerciseInMinute = self.extractFrom(results, unit: .minute())

                        self.dispatchedMainQueue {
                            self.dailyKilocalories = HKQuantity(unit: .minute(), doubleValue: totalExerciseInMinute)
                        }
                    }
                }

            store?.execute(query)
        }
    }

    func extractFrom(_ results: [HKQuantitySample], unit: HKUnit) -> Double {
        var total: Double = 0
        for result in results {
            total += result.quantity.doubleValue(for: unit)
        }

        return total
    }

    func getSleptLabel() -> String {
        var sleptLabel = "00h00"

        let (hours, minutes) = getHoursAndMinutesSlept()

        if hours > 0 && hours < 10 {
            sleptLabel = "0\(hours)h"
        } else if hours == 0 {
            sleptLabel = "00h"
        } else {
            sleptLabel = "\(hours)h"
        }

        if minutes > 0 && minutes < 10 {
            sleptLabel += "0\(minutes)"
        } else if minutes == 0 {
            sleptLabel += "00"
        } else {
            sleptLabel += "\(minutes)"
        }

        return sleptLabel
    }

    func getFeeling() {
        dispatchedMainQueue {
            self.feeling = self.feelingViewModel.getLastFeeling()
        }
    }

    private func getHoursAndMinutesSlept() -> (Int, Int) {
        return (
            Int(sleptHours.doubleValue(for: .second())) / 3600,
            (Int(sleptHours.doubleValue(for: .second()))  % 3600) / 60
        )
    }
}
