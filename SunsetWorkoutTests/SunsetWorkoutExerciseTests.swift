//
//  SunsetWorkoutExerciseTests.swift
//  SunsetWorkoutTests
//
//  Created by Paul Oggero on 22/10/2022.
//

import XCTest
import RealmSwift
@testable import SunsetWorkout

final class SunsetWorkoutExerciseTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "SunsetWorkoutTestsRealmExerciseTest"
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
            ],
            "exercises": getExercisesStrengthMockModel()
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
            ],
            "exercises": getExercisesHIITMockModel()
        ])
    }

    func getExercisesHIITMockModel() -> [SWExerciseEntity] {
        return [
            SWExerciseEntity(value: [
                "_id": UUID().uuidString,
                "name": "Burpees",
                "order": 1,
                "metadata": [
                    getMetadataModelFrom(type: .exerciseBreak, value: "20"),
                    getMetadataModelFrom(type: .roundDuration, value: "30"),
                    getMetadataModelFrom(type: .roundBreak, value: "10"),
                    getMetadataModelFrom(type: .roundNumber, value: "5")
                ]
            ]),
            SWExerciseEntity(value: [
                "_id": UUID().uuidString,
                "name": "Jumping Jacks",
                "order": 2,
                "metadata": [
                    getMetadataModelFrom(type: .exerciseBreak, value: "20"),
                    getMetadataModelFrom(type: .roundDuration, value: "30"),
                    getMetadataModelFrom(type: .roundBreak, value: "10"),
                    getMetadataModelFrom(type: .roundNumber, value: "5")
                ]
            ]),
            SWExerciseEntity(value: [
                "_id": UUID().uuidString,
                "name": "Push Ups",
                "order": 3,
                "metadata": [
                    getMetadataModelFrom(type: .exerciseBreak, value: "20"),
                    getMetadataModelFrom(type: .roundDuration, value: "30"),
                    getMetadataModelFrom(type: .roundBreak, value: "10"),
                    getMetadataModelFrom(type: .roundNumber, value: "5")
                ]
            ])
        ]
    }

    func getExercisesStrengthMockModel() -> [SWExerciseEntity] {
        return [
            SWExerciseEntity(value: [
                "_id": UUID().uuidString,
                "name": "Burpees",
                "order": 1,
                "metadata": [
                    getMetadataModelFrom(type: .exerciseBreak, value: "120"),
                    getMetadataModelFrom(type: .serieBreak, value: "60"),
                    getMetadataModelFrom(type: .serieNumber, value: "6"),
                    getMetadataModelFrom(type: .repetitionGoal, value: "12")
                ]
            ]),
            SWExerciseEntity(value: [
                "_id": UUID().uuidString,
                "name": "Jumping Jacks",
                "order": 2,
                "metadata": [
                    getMetadataModelFrom(type: .exerciseBreak, value: "120"),
                    getMetadataModelFrom(type: .serieBreak, value: "60"),
                    getMetadataModelFrom(type: .serieNumber, value: "6"),
                    getMetadataModelFrom(type: .repetitionGoal, value: "12")
                ]
            ]),
            SWExerciseEntity(value: [
                "_id": UUID().uuidString,
                "name": "Push Ups",
                "order": 3,
                "metadata": [
                    getMetadataModelFrom(type: .exerciseBreak, value: "120"),
                    getMetadataModelFrom(type: .serieBreak, value: "45"),
                    getMetadataModelFrom(type: .serieNumber, value: "6"),
                    getMetadataModelFrom(type: .repetitionGoal, value: "12")
                ]
            ])
        ]
    }

    func testAddStrengthWorkoutWithExercisesWithProjection() throws {
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

    func testAddHIITWorkoutWithExercisesWithProjection() throws {
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

    func testAddStrengthWithExercisesWithViewModel() throws {
        let viewModel = WorkoutViewModel()
        viewModel.workout = SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining)

        let exercises = [
            SWExercise.getMockWithName("Push ups", for: viewModel.workout, order: 1),
            SWExercise.getMockWithName("Pull ups", for: viewModel.workout, order: 2)
        ]

        viewModel.workout?.exercises.append(contentsOf: exercises)
        viewModel.saveWorkout()

        XCTAssertTrue(viewModel.saved)
    }

    func testAddHIITWithExercisesWithViewModel() throws {
        let viewModel = WorkoutViewModel()
        viewModel.workout = SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining)

        let exercises = [
            SWExercise.getMockWithName("Burpees", for: viewModel.workout, order: 1),
            SWExercise.getMockWithName("Jumping Jacks", for: viewModel.workout, order: 2)
        ]

        viewModel.workout?.exercises.append(contentsOf: exercises)
        viewModel.saveWorkout()

        XCTAssertTrue(viewModel.saved)
    }

    func testAddHIITThenAddExerciseThenSaveWithViewModel() throws {
        let workoutViewModel = WorkoutViewModel()
        let workout = SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining)
        workoutViewModel.workout = workout
        workoutViewModel.saveWorkout()

        let viewModel = WorkoutExerciseViewModel(workoutUUID: workout.id)
        viewModel.name = "Burpees"
        viewModel.saveExercise()

        workoutViewModel.find(workout.id)

        XCTAssertTrue(viewModel.isHIITTraining)
        XCTAssertFalse(viewModel.isTraditionalTraining)
        XCTAssertEqual(workoutViewModel.workout?.exercises.count, 1)
        XCTAssertNil(workoutViewModel.error)
        XCTAssertNil(viewModel.error)
    }

    func testAddHIITWithExercisesSameOrderWithViewModel() throws {
        let workoutViewModel = WorkoutViewModel()
        let workout = SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining)
        workoutViewModel.workout = workout
        workoutViewModel.saveWorkout()

        let viewModel = WorkoutExerciseViewModel(workoutUUID: workout.id)
        viewModel.exercise = SWExercise.getMockWithName("Burpees", for: workout)
        viewModel.saveExercise()

        viewModel.exercise = SWExercise.getMockWithName("Jumping Jacks", for: workout, order: 1)
        viewModel.saveExercise()

        workoutViewModel.find(workout.id)

        XCTAssertTrue(viewModel.isTraditionalTraining)
        XCTAssertFalse(viewModel.isHIITTraining)
        XCTAssertEqual(workoutViewModel.workout?.exercises.count, 1)
        XCTAssertNil(workoutViewModel.error)
        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error?.error as? SWExerciseError, SWExerciseError.severalOrders)
    }

    func testAddHIITWithExerciseEmptyNameWithViewModel() throws {
        let workoutViewModel = WorkoutViewModel()
        let workout = SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining)
        workoutViewModel.workout = workout
        workoutViewModel.saveWorkout()

        let viewModel = WorkoutExerciseViewModel(workoutUUID: workout.id)
        viewModel.exercise = SWExercise.getMockWithName("", for: workout)
        viewModel.saveExercise()

        XCTAssertNotNil(viewModel.error)
        XCTAssertEqual(viewModel.error?.error as? SWExerciseError, SWExerciseError.noName)
    }

    func testAddStrengthWithExerciseWithViewModel() throws {
        guard let realm = try? Realm() else { return XCTFail("Failed to instanciate Realm") }

        let viewModel = WorkoutViewModel()
        let exercises = [
            SWExercise(name: "Push ups", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "120"),
                SWMetadata(type: .serieBreak, value: "20"),
                SWMetadata(type: .serieNumber, value: "6"),
                SWMetadata(type: .repetitionGoal, value: "12")
            ]),
            SWExercise(name: "Pull ups", order: 2, metadata: [
                SWMetadata(type: .exerciseBreak, value: "120"),
                SWMetadata(type: .serieBreak, value: "20"),
                SWMetadata(type: .serieNumber, value: "6"),
                SWMetadata(type: .repetitionGoal, value: "12")
            ])
        ]

        viewModel.workout = SWWorkout.getMockWithName("Test Strength",
                                                      type: .traditionalStrengthTraining,
                                                      exercises: exercises)
        viewModel.saveWorkout()
        XCTAssertTrue(viewModel.saved)

        guard let workoutModel = realm.objects(SWWorkoutEntity.self)
            .first(where: { $0.name == "Test Strength" }) else { return XCTFail("Failed to retrieve first object") }

        XCTAssertEqual(workoutModel.exercises.count, 2)
    }

    func testAddHIITWithExerciseWithViewModel() throws {
        guard let realm = try? Realm() else { return XCTFail("Failed to instanciate Realm") }

        let viewModel = WorkoutViewModel()
        let exercises = [
            SWExercise(name: "Burpees", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "30"),
                SWMetadata(type: .roundBreak, value: "20"),
                SWMetadata(type: .roundNumber, value: "6"),
                SWMetadata(type: .roundDuration, value: "30")
            ]),
            SWExercise(name: "Jumping Jacks", order: 2, metadata: [
                SWMetadata(type: .exerciseBreak, value: "30"),
                SWMetadata(type: .roundBreak, value: "20"),
                SWMetadata(type: .roundNumber, value: "6"),
                SWMetadata(type: .roundDuration, value: "30")
            ])
        ]

        viewModel.workout = SWWorkout.getMockWithName("Test Strength",
                                                      type: .highIntensityIntervalTraining,
                                                      exercises: exercises)
        viewModel.saveWorkout()

        XCTAssertTrue(viewModel.saved)

        guard let workoutModel = realm.objects(SWWorkoutEntity.self)
            .first(where: { $0.name == "Test Strength" }) else { return XCTFail("Failed to retrieve first object") }
        XCTAssertEqual(workoutModel.exercises.count, 2)
    }
}
