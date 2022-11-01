//
//  ActivityView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 26/10/2022.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var viewModel: ActivityViewModel

    var timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

    init(workout: SWWorkout) {
        _viewModel = StateObject(wrappedValue: ActivityViewModel(workout: workout))
    }

    var body: some View {
        ZStack {
            BackgroundView()
            if viewModel.activityStateIs(.initialized) {
                InitialActivityView()
            } else {
                if viewModel.isFinished() {
                    VStack {
                        Spacer()
                        Text("finished!")
                        Spacer()
                    }
                } else {
                    if let currentExercise = viewModel.activity.currentExercise {
                        VStack {
                            VStack {
                                if viewModel.activityStateIs(.running) {
                                    Text(currentExercise.name)
                                        .font(.system(.title3))

                                    Text(viewModel.getCurrentRepetitionLocalizedString())
                                        .padding(.top, 12)
                                } else if viewModel.activityStateIs(.inBreak) {
                                    Text(NSLocalizedString("activity.in.break", comment: "In break label"))
                                        .font(.title3)

                                    if viewModel.activity.exerciseHasChanged {
                                        Text(viewModel.getNextExerciseLocalizedString())
                                            .padding(.top, 12)
                                    }

                                } else if viewModel.activityStateIs(.starting) {
                                    Text(NSLocalizedString("activity.starting", comment: "Starting text"))
                                    Text(NSLocalizedString("activity.be.ready", comment: "Be ready text"))
                                        .padding(.top, 12)
                                }

                                Spacer()

                                if viewModel.shouldShowTimer {
                                    ProgressBar(
                                        progress: $viewModel.timePassedPercentage,
                                        progressShow: $viewModel.timeRemaining)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: 350)

                                    Spacer()
                                }

                                HStack {
                                    if viewModel.canAskForReplay() {
                                        ActivityButton {
                                            ActivityPlayButton()
                                        } action: {
                                            viewModel.play()
                                        }
                                    }

                                    if viewModel.canAskForPause() {
                                        ActivityButton {
                                            ActivityPauseButton()
                                        } action: {
                                            viewModel.pause()
                                        }
                                    }

                                    ActivityButton {
                                        ActivityStopButton()
                                    } action: {
                                        viewModel.cancel()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            print("timer")
            print("state: \(viewModel.activity.state)")
            print("finished: \(viewModel.isFinished())")
            viewModel.updateTimer()
        }
        .environmentObject(viewModel)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static let HIITExample = SWWorkout.getMockWithName("Test HIIT", type: .highIntensityIntervalTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "20"),
        SWMetadata(type: .roundBreak, value: "0"),
        SWMetadata(type: .roundNumber, value: "2"),
        SWMetadata(type: .roundDuration, value: "10")
    ], exercises: [
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
    static var previews: some View {
        ActivityView(workout: HIITExample)
    }
}
