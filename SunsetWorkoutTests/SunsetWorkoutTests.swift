//
//  SunsetWorkoutTests.swift
//  SunsetWorkoutTests
//
//  Created by Paul Oggero on 24/08/2022.
//

import XCTest
@testable import SunsetWorkout
@testable import RealmSwift

class SunsetWorkoutTests: XCTestCase {

    override class func setUp() {
        super.setUp()

        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "SunsetWorkoutTestsRealm"
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddStrengthWorkoutWithProjection() throws {
        guard let realm = try? Realm() else { return XCTFail("Failed to instanciate Realm") }

        try? realm.write {
            realm.add(SWWorkoutModel(value: [
                "_id": UUID().uuidString,
                "name": "Test Strength",
                "rawType": SWWorkoutType.traditionalStrengthTraining.rawValue,
                "metadata": [
                    SWWorkoutMetadataModel(value: [
                        "_id": UUID().uuidString,
                        "rawType": SWMetadataType.exerciseBreak.rawValue,
                        "value": "120"
                    ]),
                    SWWorkoutMetadataModel(value: [
                        "_id": UUID().uuidString,
                        "rawType": SWMetadataType.serieBreak.rawValue,
                        "value": "60"
                    ]),
                    SWWorkoutMetadataModel(value: [
                        "_id": UUID().uuidString,
                        "rawType": SWMetadataType.serieNumber.rawValue,
                        "value": "6"
                    ]),
                    SWWorkoutMetadataModel(value: [
                        "_id": UUID().uuidString,
                        "rawType": SWMetadataType.repetitionGoal.rawValue,
                        "value": "12"
                    ])
                ]
            ]), update: .modified)
        }

        guard let workoutModel = realm.objects(SWWorkoutModel.self)
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
            realm.add(SWWorkoutModel(value: [
                "_id": UUID().uuidString,
                "name": "Test HIIT",
                "rawType": SWWorkoutType.highIntensityIntervalTraining.rawValue,
                "metadata": [
                    SWWorkoutMetadataModel(value: [
                        "_id": UUID().uuidString,
                        "rawType": SWMetadataType.exerciseBreak.rawValue,
                        "value": "20"
                    ]),
                    SWWorkoutMetadataModel(value: [
                        "_id": UUID().uuidString,
                        "rawType": SWMetadataType.roundBreak.rawValue,
                        "value": "10"
                    ]),
                    SWWorkoutMetadataModel(value: [
                        "_id": UUID().uuidString,
                        "rawType": SWMetadataType.roundNumber.rawValue,
                        "value": "5"
                    ])
                ]
            ]), update: .modified)
        }

        guard let workoutModel = realm.objects(SWWorkoutModel.self)
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
        let metadata = [
            SWMetadata(type: .exerciseBreak, value: "120"),
            SWMetadata(type: .roundBreak, value: "10"),
            SWMetadata(type: .serieBreak, value: "20"),
            SWMetadata(type: .roundNumber, value: "5"),
            SWMetadata(type: .serieNumber, value: "6"),
            SWMetadata(type: .repetitionGoal, value: "12")
        ]

        let workout = SWWorkout(name: "Test Strength", type: .traditionalStrengthTraining, metadata: metadata)
        viewModel.workout = workout
        viewModel.saveWorkout()

        XCTAssertTrue(viewModel.saved)
    }

    func testAddHIITWithViewModel() throws {
        let viewModel = WorkoutViewModel()
        let metadata = [
            SWMetadata(type: .exerciseBreak, value: "120"),
            SWMetadata(type: .roundBreak, value: "10"),
            SWMetadata(type: .serieBreak, value: "20"),
            SWMetadata(type: .roundNumber, value: "5"),
            SWMetadata(type: .serieNumber, value: "6"),
            SWMetadata(type: .repetitionGoal, value: "12")
        ]

        let workout = SWWorkout(name: "Test HIIT", type: .highIntensityIntervalTraining, metadata: metadata)
        viewModel.workout = workout
        viewModel.saveWorkout()

        XCTAssertTrue(viewModel.saved)
    }
}
