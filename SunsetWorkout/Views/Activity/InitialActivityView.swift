//
//  InitialActivityView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 29/10/2022.
//

import SwiftUI

struct InitialActivityView: View {
    @EnvironmentObject var viewModel: ActivityViewModel

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 20) {
                Text(String(
                    format: NSLocalizedString("activity.selected", comment: "Selected activity"),
                    viewModel.activity.workout.name)
                )
                Image("trainer_blue")
                    .resizable()
                    .scaledToFit()
                Text("activity.start.preface")
            }
            Spacer()
            if viewModel.canStart {
                ActivityButton {
                    ActivityBeganButton()
                } action: {
                    viewModel.getNext()
                    viewModel.setupTimer()
                }
                Spacer()
            } else {
                Text("activity.cant.start")
            }
        }
        .padding(.horizontal)
    }
}

struct InitialActivityView_Previews: PreviewProvider {
    static let StrengthExample = SWWorkout(name: "Test Strength", type: .traditionalStrengthTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "120"),
        SWMetadata(type: .serieBreak, value: "60"),
        SWMetadata(type: .serieNumber, value: "6"),
        SWMetadata(type: .repetitionGoal, value: "12")
    ])
    static var previews: some View {
        InitialActivityView()
            .environmentObject(ActivityViewModel(workout: StrengthExample))
    }
}
