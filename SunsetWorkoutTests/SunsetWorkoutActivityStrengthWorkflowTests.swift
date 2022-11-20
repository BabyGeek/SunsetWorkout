//
//  SunsetWorkoutActivityStrengthWorkflowTests.swift
//  SunsetWorkoutTests
//
//  Created by Paul Oggero on 05/11/2022.
//

@testable import SunsetWorkout
import RealmSwift
import XCTest

final class SunsetWorkoutStrengthWorkflowTests: XCTestCase {
    override class func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "SunsetWorkoutTestsRealmStrength"
    }

    func testActivityStartingToRunning() {
        let workout = SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining)
        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        viewModel.setupTimer()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        XCTAssertTrue(viewModel.activityStateIs(.running))
    }

    func testActivityInRoundBreak() {
        let workout =  SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining, exercises: [
            SWExercise(name: "Push ups", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .serieBreak, value: "10"),
                SWMetadata(type: .serieNumber, value: "2"),
                SWMetadata(type: .repetitionGoal, value: "12")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        viewModel.getNext()
        viewModel.setupTimer()

        XCTAssertTrue(viewModel.activityStateIs(.inBreak))
        XCTAssertTrue(viewModel.activity.workoutInputs.isEmpty)
        XCTAssertFalse(viewModel.activity.exerciseHasChanged)
    }

    func testActivityAddInputAndInRoundBreak() {
        let workout =  SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining, exercises: [
            SWExercise(name: "Push ups", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .serieBreak, value: "10"),
                SWMetadata(type: .serieNumber, value: "2"),
                SWMetadata(type: .repetitionGoal, value: "12")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        viewModel.prepareAddInput()
        viewModel.saveInputSerie("12")

        viewModel.getNext()
        viewModel.setupTimer()

        XCTAssertFalse(viewModel.waitForInput)

        XCTAssertTrue(viewModel.activityStateIs(.inBreak))
        XCTAssertFalse(viewModel.activity.exerciseHasChanged)

        XCTAssertFalse(viewModel.activity.workoutInputs.isEmpty)
        XCTAssertEqual(viewModel.activity.workoutInputs.first?.value.first!["currentRepetition"] as? Int, 1)
        XCTAssertEqual(viewModel.activity.workoutInputs.first?.value.first!["value"] as? String, "12")
    }

    func testActivityInExerciseBreak() {
        let workout =  SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining, exercises: [
            SWExercise(name: "Push ups", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .serieBreak, value: "10"),
                SWMetadata(type: .serieNumber, value: "2"),
                SWMetadata(type: .repetitionGoal, value: "12")
            ]),
            SWExercise(name: "Push ups 2", order: 2, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .serieBreak, value: "10"),
                SWMetadata(type: .serieNumber, value: "2"),
                SWMetadata(type: .repetitionGoal, value: "12")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        XCTAssertTrue(viewModel.waitForInput)
        viewModel.getNext()
        viewModel.setupTimer()

        for _ in 0...10 {
            viewModel.updateTimer()
        }

        viewModel.getNext()

        XCTAssertTrue(viewModel.activityStateIs(.inBreak))
        XCTAssertTrue(viewModel.activity.exerciseHasChanged)
    }

    func testActivityHasNoBreakBetweenExercises() {
        let workout =  SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining, exercises: [
            SWExercise(name: "Push ups", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "0"),
                SWMetadata(type: .serieBreak, value: "10"),
                SWMetadata(type: .serieNumber, value: "2"),
                SWMetadata(type: .repetitionGoal, value: "12")
            ]),
            SWExercise(name: "Push ups 2", order: 2, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .serieBreak, value: "10"),
                SWMetadata(type: .serieNumber, value: "2"),
                SWMetadata(type: .repetitionGoal, value: "12")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        viewModel.getNext()
        viewModel.setupTimer()

        for _ in 0...10 {
            viewModel.updateTimer()
        }

        viewModel.getNext()
        viewModel.updateTimer()
        viewModel.setupTimer()

        XCTAssertTrue(viewModel.activityStateIs(.running))
        XCTAssertTrue(viewModel.activity.exerciseHasChanged)
    }

    func testActivityIsFinished() {
        let workout =  SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining, exercises: [
                SWExercise(name: "Push ups", order: 1, metadata: [
                    SWMetadata(type: .exerciseBreak, value: "0"),
                    SWMetadata(type: .serieBreak, value: "10"),
                    SWMetadata(type: .serieNumber, value: "1"),
                    SWMetadata(type: .repetitionGoal, value: "12")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        viewModel.getNext()
        viewModel.setupTimer()

        for _ in 0...10 {
            viewModel.updateTimer()
        }

        viewModel.setupTimer()
        viewModel.getNext()
        viewModel.updateTimer()

        viewModel.setupTimer()
        XCTAssertTrue(viewModel.activityStateIs(.finished))
        XCTAssertTrue(viewModel.isFinished)
        XCTAssertFalse(viewModel.shouldShowTimer)
    }

    func testActivityIsPaused() {
        let workout =  SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining)

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        viewModel.updateTimer()
        viewModel.pause()

        XCTAssertTrue(viewModel.canAskForReplay)
        XCTAssertFalse(viewModel.canAskForPause)
        XCTAssertTrue(viewModel.activityStateIs(.paused))
        XCTAssertFalse(viewModel.shouldShowTimer)
    }

    func testActivityIsPausedThenPlayed() {
        let workout =  SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining)

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        viewModel.updateTimer()
        viewModel.pause()
        viewModel.play()

        XCTAssertTrue(viewModel.canAskForPause)
        XCTAssertFalse(viewModel.canAskForReplay)
        XCTAssertTrue(viewModel.activityStateIs(.running))
        XCTAssertFalse(viewModel.shouldShowTimer)
    }

    func testActivityIsCanceled() {
        let workout =  SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining)

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        viewModel.updateTimer()
        viewModel.cancel()
        viewModel.getNext()

        viewModel.setupTimer()
        XCTAssertTrue(viewModel.activityStateIs(.canceled))
        XCTAssertTrue(viewModel.isFinished)
        XCTAssertFalse(viewModel.shouldShowTimer)
    }

    @MainActor func testActivityIsSaved() {
        let workout =  SWWorkout.getMockWithName("Test Strength", type: .traditionalStrengthTraining, exercises: [
                SWExercise(name: "Push ups", order: 1, metadata: [
                    SWMetadata(type: .exerciseBreak, value: "0"),
                    SWMetadata(type: .serieBreak, value: "10"),
                    SWMetadata(type: .serieNumber, value: "1"),
                    SWMetadata(type: .repetitionGoal, value: "12")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        viewModel.getNext()
        viewModel.setupTimer()

        for _ in 0...10 {
            viewModel.updateTimer()
        }

        viewModel.setupTimer()
        viewModel.getNext()
        viewModel.updateTimer()

        viewModel.setupTimer()
        viewModel.save()
        XCTAssertTrue(viewModel.activityStateIs(.finished))
        XCTAssertTrue(viewModel.isFinished)
        XCTAssertTrue(viewModel.saved)
        XCTAssertFalse(viewModel.shouldShowTimer)
    }
}
