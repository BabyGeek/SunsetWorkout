//
//  SunsetWorkoutTests.swift
//  SunsetWorkoutTests
//
//  Created by Paul Oggero on 24/08/2022.
//

import XCTest
import RealmSwift
@testable import SunsetWorkout

class SunsetWorkoutTests: XCTestCase {

    override class func setUp() {
        super.setUp()

        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "SunsetWorkoutTestsRealm"
    }

    func getMetadataModelFrom(type: SWMetadataType, value: String) -> SWWorkoutMetadataEntity {
        return SWWorkoutMetadataEntity(value: [
            "_id": UUID().uuidString,
            "rawType": type.rawValue,
            "value": value
        ])
    }

    func getStrengthMockWorkoutModel() -> SWWorkoutEntity {
        return SWWorkoutEntity(value: [
            "_id": UUID().uuidString,
            "name": "Test Strength",
            "rawType": SWWorkoutType.traditionalStrengthTraining.rawValue,
            "metadata": [
                getMetadataModelFrom(type: .exerciseBreak, value: "120"),
                getMetadataModelFrom(type: .serieBreak, value: "60"),
                getMetadataModelFrom(type: .serieNumber, value: "6"),
                getMetadataModelFrom(type: .repetitionGoal, value: "12")
            ]
        ])
    }

    func getHIITMockWorkoutModel() -> SWWorkoutEntity {
        return SWWorkoutEntity(value: [
            "_id": UUID().uuidString,
            "name": "Test HIIT",
            "rawType": SWWorkoutType.highIntensityIntervalTraining.rawValue,
            "metadata": [
                getMetadataModelFrom(type: .exerciseBreak, value: "20"),
                getMetadataModelFrom(type: .roundDuration, value: "30"),
                getMetadataModelFrom(type: .roundBreak, value: "10"),
                getMetadataModelFrom(type: .roundNumber, value: "5")
            ]
        ])
    }

    func testAddStrengthWorkoutWithProjection() throws {
        guard let realm = try? Realm() else { return XCTFail("Failed to instanciate Realm") }

        try? realm.write {
            realm.add(getStrengthMockWorkoutModel(), update: .modified)
        }

        guard let workoutModel = realm.objects(SWWorkoutEntity.self)
            .first(where: { $0.name == "Test Strength" }) else { return XCTFail("Failed to retrieve first object") }

        XCTAssert(workoutModel.name == "Test Strength")
        XCTAssert(workoutModel.rawType == SWWorkoutType.traditionalStrengthTraining.rawValue)

        try? realm.write {
            workoutModel.name = "Update Strength"
        }

        XCTAssert(workoutModel.name == "Update Strength")
    }

    func testAddHIITWorkoutWithProjection() throws {
        guard let realm = try? Realm() else { return XCTFail("Failed to instanciate Realm") }

        try? realm.write {
            realm.add(getHIITMockWorkoutModel(), update: .modified)
        }

        guard let workoutModel = realm.objects(SWWorkoutEntity.self)
            .first(where: { $0.name == "Test HIIT" }) else { return XCTFail("Failed to retrieve first object") }

        XCTAssert(workoutModel.name == "Test HIIT")
        XCTAssert(workoutModel.rawType == SWWorkoutType.highIntensityIntervalTraining.rawValue)

        try? realm.write {
            workoutModel.name = "Update HIIT"
        }

        XCTAssert(workoutModel.name == "Update HIIT")
    }

    func testAddStrengthWithViewModel() throws {
        let viewModel = WorkoutViewModel()

        viewModel.workout = SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining)
        viewModel.saveWorkout()

        XCTAssertTrue(viewModel.saved)
    }

    func testAddHIITWithViewModel() throws {
        let viewModel = WorkoutViewModel()

        viewModel.workout = SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining)
        viewModel.saveWorkout()

        XCTAssertTrue(viewModel.saved)
    }

    func testNilWorkoutSaveWithViewModel() throws {
        let viewModel = WorkoutViewModel()
        viewModel.saveWorkout()

        XCTAssertNotNil(viewModel.error)
    }

    @MainActor func testWorkoutsViewModelFetch() throws {
        let viewModel = WorkoutViewModel()
        viewModel.workout = SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining)
        viewModel.saveWorkout()

        let workoutsViewModel = WorkoutsViewModel()
        workoutsViewModel.fetch(with: SWWorkout.allByDateDESC)

        XCTAssertNotNil(workoutsViewModel.notificationToken)
        XCTAssertEqual(workoutsViewModel.workouts.count, 1)
    }
}
