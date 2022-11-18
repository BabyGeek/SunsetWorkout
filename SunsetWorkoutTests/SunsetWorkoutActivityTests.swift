//
//  SunsetWorkoutActivityTests.swift
//  SunsetWorkoutTests
//
//  Created by Paul Oggero on 31/10/2022.
//

@testable import SunsetWorkout
import XCTest

final class SunsetWorkoutActivityTests: XCTestCase {
    func testInitializeActivity() {
        let workout = SWWorkout.getMockWithName("test", type: .highIntensityIntervalTraining)
        let viewModel = ActivityViewModel(workout: workout)

        XCTAssertTrue(viewModel.activityStateIs(.initialized))
    }

    func testStartingActivity() {
        let workout = SWWorkout.getMockWithName("test", type: .highIntensityIntervalTraining)
        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        viewModel.setupTimer()

        XCTAssertTrue(viewModel.activityStateIs(.starting))
        XCTAssertTrue(viewModel.shouldShowTimer)

        XCTAssertEqual(viewModel.timePassed, 0)
        XCTAssertEqual(viewModel.timeRemaining, SWActivity.START_TIMER_DURATION)
        XCTAssertEqual(viewModel.timePassedPercentage, 0)
    }

    func testActivityUpdateTimer() {
        let workout = SWWorkout.getMockWithName("test", type: .highIntensityIntervalTraining)
        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        viewModel.setupTimer()
        viewModel.updateTimer()

        XCTAssertTrue(viewModel.activityStateIs(.starting))
        XCTAssertTrue(viewModel.shouldShowTimer)

        XCTAssertEqual(viewModel.timePassed, 1)
        XCTAssertEqual(viewModel.timeRemaining, SWActivity.START_TIMER_DURATION - 1)
        XCTAssertEqual(viewModel.timePassedPercentage, 1 / SWActivity.START_TIMER_DURATION)
    }

    func testHIITCurrentRepetitionString() {
        let workout = SWWorkout.getMockWithName("test", type: .highIntensityIntervalTraining)
        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        let localizedString = String(format: NSLocalizedString("activity.exercise.repetition", comment: ""),
                                     NSLocalizedString("workout.hiit.repetition", comment: ""),
                                     1,
                                     0)

        XCTAssertEqual(viewModel.getCurrentRepetitionLocalizedString(), localizedString)
    }

    func testStrengthCurrentRepetitionString() {
        let workout = SWWorkout.getMockWithName("test", type: .traditionalStrengthTraining)
        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        let localizedString = String(format: NSLocalizedString("activity.exercise.repetition", comment: ""),
                                     NSLocalizedString("workout.strength.repetition", comment: ""),
                                     1,
                                     0)

        XCTAssertEqual(viewModel.getCurrentRepetitionLocalizedString(), localizedString)
    }

    func testNextExerciseEmptyString() {
        let workout = SWWorkout.getMockWithName("test", type: .highIntensityIntervalTraining)
        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        let localizedString = String(
            format: NSLocalizedString("activity.exercise.next.last", comment: ""),
            NSLocalizedString("not.found", comment: ""))

        XCTAssertEqual(viewModel.getNextExerciseLocalizedString(), localizedString)
    }

    func testNextExerciseNotLastString() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining, exercises: [
            SWExercise(name: "Jumps", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "0"),
                SWMetadata(type: .roundNumber, value: "2"),
                SWMetadata(type: .roundDuration, value: "10")
            ]),
            SWExercise(name: "Jumps 2", order: 2, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "0"),
                SWMetadata(type: .roundNumber, value: "2"),
                SWMetadata(type: .roundDuration, value: "10")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        let localizedString = String(
            format: NSLocalizedString("activity.exercise.next", comment: ""),
            "Jumps")

        XCTAssertEqual(viewModel.getNextExerciseLocalizedString(), localizedString)
    }

    func testNextExerciseIsLastString() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining, exercises: [
            SWExercise(name: "Jumps", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "0"),
                SWMetadata(type: .roundNumber, value: "2"),
                SWMetadata(type: .roundDuration, value: "10")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        let localizedString = String(
            format: NSLocalizedString("activity.exercise.next.last", comment: ""),
            "Jumps")

        XCTAssertEqual(viewModel.getNextExerciseLocalizedString(), localizedString)
    }

    func testPreparedInputOnNoExercise() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining)

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        // Nothing happens guard statement
        viewModel.prepareAddInput()
    }
}
