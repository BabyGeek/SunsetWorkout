//
//  SunsetWorkoutActivityHIITWorkflowTests.swift
//  SunsetWorkoutTests
//
//  Created by Paul Oggero on 31/10/2022.
//

@testable import SunsetWorkout
import XCTest

final class SunsetWorkoutActivityHIITWorkflowTests: XCTestCase {
    func testActivityStartingToRunning() {
        let workout = SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining)
        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        viewModel.setupTimer()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        // Nothing happen went into return part
        viewModel.saveInputSerie("12")
        XCTAssertFalse(viewModel.canStart)
        XCTAssertTrue(viewModel.activityStateIs(.running))
    }

    func testActivityInRoundBreak() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining, exercises: [
            SWExercise(name: "Jumps", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "10"),
                SWMetadata(type: .roundNumber, value: "2"),
                SWMetadata(type: .roundDuration, value: "5")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        for _ in 0...10 {
            viewModel.updateTimer()
        }

        XCTAssertTrue(viewModel.canStart)
        XCTAssertTrue(viewModel.activityStateIs(.inBreak))
        XCTAssertFalse(viewModel.activity.exerciseHasChanged)
    }

    func testActivityInExerciseBreak() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining, exercises: [
            SWExercise(name: "Jumps", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "10"),
                SWMetadata(type: .roundNumber, value: "1"),
                SWMetadata(type: .roundDuration, value: "5")
            ]),
            SWExercise(name: "Jumps 2", order: 2, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "10"),
                SWMetadata(type: .roundNumber, value: "2"),
                SWMetadata(type: .roundDuration, value: "5")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        for _ in 0...5 {
            viewModel.updateTimer()
        }

        XCTAssertTrue(viewModel.activityStateIs(.inBreak))
        XCTAssertTrue(viewModel.activity.exerciseHasChanged)
    }

    func testActivityAsNoBreakBetweenRounds() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining, exercises: [
            SWExercise(name: "Jumps", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "0"),
                SWMetadata(type: .roundNumber, value: "2"),
                SWMetadata(type: .roundDuration, value: "5")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        for _ in 0...5 {
            viewModel.updateTimer()
        }

        XCTAssertTrue(viewModel.activityStateIs(.running))
        XCTAssertFalse(viewModel.activity.exerciseHasChanged)
    }

    func testActivityHasNoBreakBetweenExercises() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining, exercises: [
            SWExercise(name: "Jumps", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "0"),
                SWMetadata(type: .roundBreak, value: "10"),
                SWMetadata(type: .roundNumber, value: "1"),
                SWMetadata(type: .roundDuration, value: "5")
            ]),
            SWExercise(name: "Jumps 2", order: 2, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "10"),
                SWMetadata(type: .roundNumber, value: "2"),
                SWMetadata(type: .roundDuration, value: "5")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        for _ in 0...4 {
            viewModel.updateTimer()
        }

        XCTAssertTrue(viewModel.activityStateIs(.running))
        XCTAssertTrue(viewModel.activity.exerciseHasChanged)
    }

    func testActivityIsFinished() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining, exercises: [
            SWExercise(name: "Jumps", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "0"),
                SWMetadata(type: .roundNumber, value: "1"),
                SWMetadata(type: .roundDuration, value: "5")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        for _ in 0...5 {
            viewModel.updateTimer()
        }

        viewModel.setupTimer()
        XCTAssertTrue(viewModel.activityStateIs(.finished))
        XCTAssertTrue(viewModel.isFinished)
        XCTAssertFalse(viewModel.shouldShowTimer)
    }

    func testActivityIsPaused() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining)

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        viewModel.updateTimer()
        viewModel.pause()

        XCTAssertTrue(viewModel.canAskForReplay)
        XCTAssertFalse(viewModel.canAskForPause)
        XCTAssertTrue(viewModel.activityStateIs(.paused))
        XCTAssertTrue(viewModel.shouldShowTimer)
    }

    func testActivityIsPausedThenPlayed() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining)

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        viewModel.updateTimer()
        viewModel.pause()
        viewModel.play()

        XCTAssertTrue(viewModel.canAskForPause)
        XCTAssertFalse(viewModel.canAskForReplay)
        XCTAssertTrue(viewModel.activityStateIs(.running))
        XCTAssertTrue(viewModel.shouldShowTimer)
    }

    func testActivityIsCanceled() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining)

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()
        viewModel.updateTimer()
        viewModel.cancel()

        viewModel.setupTimer()
        XCTAssertTrue(viewModel.activityStateIs(.canceled))
        XCTAssertTrue(viewModel.isFinished)
        XCTAssertFalse(viewModel.shouldShowTimer)
    }

    @MainActor func testActivityIsSaved() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining, exercises: [
            SWExercise(name: "Jumps", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "0"),
                SWMetadata(type: .roundNumber, value: "1"),
                SWMetadata(type: .roundDuration, value: "5")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        for _ in 0...5 {
            viewModel.updateTimer()
        }

        viewModel.setupTimer()
        viewModel.save()
        XCTAssertTrue(viewModel.activityStateIs(.finished))
        XCTAssertTrue(viewModel.isFinished)
        XCTAssertTrue(viewModel.saved)
        XCTAssertFalse(viewModel.shouldShowTimer)
    }

    func testActivityIsSkippableAndSkip() {
        let workout =  SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining, exercises: [
            SWExercise(name: "Jumps", order: 1, metadata: [
                SWMetadata(type: .exerciseBreak, value: "20"),
                SWMetadata(type: .roundBreak, value: "0"),
                SWMetadata(type: .roundNumber, value: "2"),
                SWMetadata(type: .roundDuration, value: "5")
            ])
        ])

        let viewModel = ActivityViewModel(workout: workout)
        viewModel.getNext()

        for _ in 0...Int(SWActivity.START_TIMER_DURATION) {
            viewModel.updateTimer()
        }

        XCTAssertTrue(viewModel.canSkip)
        viewModel.skip()
        XCTAssertEqual(viewModel.activity.currentExerciseRepetition, 2)
    }
}
