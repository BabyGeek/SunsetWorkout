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
                if viewModel.isFinished {
                    FinishedActivityView()
                } else {
                    MainActivityView()
                }
            }

            ActivitySerieInputAlertView { goalValue in
                viewModel.presentSerieAlert = false
                viewModel.saveInputSerie(goalValue)
            }
            .conditional(!viewModel.presentSerieAlert) { view in
                    view
                        .hidden()
            }
        }
        .onReceive(timer) { _ in
            if viewModel.isFinished {
                timer.upstream.connect().cancel()
                viewModel.save()
            }

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
