//
//  ActivityView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 26/10/2022.
//

import SwiftUI

struct ActivityView: View {
    @StateObject private var viewModel: ActivityViewModel

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(workout: SWWorkout) {
        _viewModel = StateObject(wrappedValue: ActivityViewModel(workout: workout))
    }

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                ProgressBar(
                    progress: $viewModel.timePassedPercentage,
                    progressShow: $viewModel.timeRemaining)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 350)

                Spacer()

                HStack {
                    Button {
                        viewModel.pause()
                    } label: {
                        ActivityPauseButton()
                    }

                    Button {
                        viewModel.launchBreak()
                    } label: {
                        ActivityPlayButton()
                    }

                    Button {
                        viewModel.launchBreak(reset: true)
                    } label: {
                        ActivityStopButton()
                    }
                }
                .padding(.horizontal)
            }
            .onReceive(timer) { _ in
                viewModel.updateTimer()
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static let HIITExample = SWWorkout(name: "Test HIIT", type: .highIntensityIntervalTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "20"),
        SWMetadata(type: .roundBreak, value: "10"),
        SWMetadata(type: .roundNumber, value: "5")
    ])

    static let StrengthExample = SWWorkout(name: "Test Strength", type: .traditionalStrengthTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "120"),
        SWMetadata(type: .serieBreak, value: "60"),
        SWMetadata(type: .serieNumber, value: "6"),
        SWMetadata(type: .repetitionGoal, value: "12")
    ])

    static var previews: some View {
        ActivityView(workout: HIITExample)
    }
}
