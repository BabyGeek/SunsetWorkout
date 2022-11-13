//
//  DashboardViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/09/2022.
//

import Combine
import HealthKit

/// Dashboard ViewModel
class DashboardViewModel: SWHealthStoreManager {
    var urlSession = URLSession.shared
    var feelingViewModel = FeelingViewModel()

    @Published var quote: Quote?
    @Published var feeling: Feeling?
    @Published var error: SWError?

    @Published var sleptHours: HKQuantity = HKQuantity(unit: .second(), doubleValue: 0)
    @Published var dailyKilocalories: HKQuantity = HKQuantity(unit: .kilocalorie(), doubleValue: 0)
    @Published var dailyTrainedTime: HKQuantity = HKQuantity(unit: .minute(), doubleValue: 0)

    var cancellable: AnyCancellable?

    /// Get updated values for dashboard
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

    /// Fetch daily quote
    func getDailyQuote() {
        cancellable?.cancel()

        cancellable = loadQuote()
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = SWError(error: error)
                case .finished:
                    debugPrint("Publisher is finished")
                }
            } receiveValue: { [weak self] in
                guard let self else { return }
                self.quote = $0
            }
    }

    /// Get random quote with maxLength and tags
    /// - Parameters:
    ///   - maxLength: `String` = `"122"`
    ///   - tags: `String` = `"sports,competition"`
    /// - Returns: `AnyPublisher<Quote, Error>`
    func loadQuote(
        maxLength: String = "90",
        tags: String = "sports,competition") -> AnyPublisher<Quote, Error> {
        urlSession.quotablePublisher(
            on: .quotableAPIHost,
            for: .random(maxLength: maxLength, tags: tags),
            using: ())
    }

    /// Get HK slept hours
    func getSleptHours() {
        if let sleepType = HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis) {
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

            let predicate = HKSampleQuery.predicateForSamples(
                withStart: Date().getDay(order: .before, type: .evening),
                end: Date(),
                options: [.strictStartDate, .strictEndDate])

            let query = HKSampleQuery(
                sampleType: sleepType,
                predicate: predicate,
                limit: 0,
                sortDescriptors: [sortDescriptor]) { (_, tmpResult, error) -> Void in
                if let error {
                    self.error = SWError(error: error)
                    return
                }

                if let result = tmpResult {
                    var sleptTimeTotal: Double = 0

                    for item in result {

                        if let sample = item as? HKCategorySample {
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

    /// Get HK active energy burned
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
                    if let error {
                        self.error = SWError(error: error)
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

    /// Get HK exercise time
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
                    if let error {
                        self.error = SWError(error: error)
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

    /// Extract total from quantity samples
    /// - Parameters:
    ///   - results: `[HKQuantitySample]`
    ///   - unit: `HKUnit`
    /// - Returns: `Double`
    func extractFrom(_ results: [HKQuantitySample], unit: HKUnit) -> Double {
        var total: Double = 0
        for result in results {
            total += result.quantity.doubleValue(for: unit)
        }

        return total
    }

    /// Get slept string label
    /// - Returns: `String`
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

    /// Get the last feeling selected
    func getFeeling() {
        dispatchedMainQueue {
            self.feeling = self.feelingViewModel.getLastFeeling()
        }
    }

    func getAuthorSaidLabel(author: String) -> String {
        String(format: NSLocalizedString("dashboard.said.by", comment: "Author said"), author)
    }

    /// Get slept time in hours and minutes
    /// - Returns: `(Int, Int)`
    private func getHoursAndMinutesSlept() -> (Int, Int) {
        return (
            Int(sleptHours.doubleValue(for: .second())) / 3600,
            (Int(sleptHours.doubleValue(for: .second()))  % 3600) / 60
        )
    }
}
