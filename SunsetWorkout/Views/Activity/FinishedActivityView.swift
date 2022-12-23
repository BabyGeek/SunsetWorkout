//
//  FinishedActivityView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 13/11/2022.
//

import SwiftUI

struct FinishedActivityView: View {
    @EnvironmentObject var viewModel: ActivityViewModel
    @Environment(\.presentationMode) var presentationMode

    @State var goToSummary: Bool = false
    @State var goToWorkout: Bool = false

    var body: some View {
        VStack(spacing: 80) {
            if viewModel.saved && viewModel.activitySummary != nil {
                NavigationLink(
                    destination: HistoryView(summary: viewModel.activitySummary!),
                    isActive: $goToSummary) {
                    EmptyView()
                }

                NavigationLink(
                    destination: WorkoutView(workout: viewModel.activity.workout),
                    isActive: $goToWorkout) {
                    EmptyView()
                }

                SWButton(tint: .green) {
                    SWButtonWithIconAndTitle(
                        titleKey: "button.go.to.summary",
                        iconName: "calendar.badge.clock"
                    )
                } action: {
                    goToSummary = true
                }

                SWButton(tint: .yellow) {
                    SWButtonWithIconAndTitle(
                        titleKey: "button.go.to.workout",
                        iconName: "figure.strengthtraining.traditional"
                    )
                } action: {
                    goToWorkout = true
                }

                SWButton(tint: .blue) {
                    SWButtonWithIconAndTitle(
                        titleKey: "button.go.to.launch",
                        iconName: "play.fill"
                    )
                } action: {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            } else {
                if viewModel.activityLastStateIs(.initialized) || viewModel.activityLastStateIs(.starting) {
                    SWButton(tint: .yellow) {
                        SWButtonWithIconAndTitle(
                            titleKey: "button.go.to.workout",
                            iconName: "figure.strengthtraining.traditional"
                        )
                    } action: {
                        goToWorkout = true
                    }

                    SWButton(tint: .blue) {
                        SWButtonWithIconAndTitle(
                            titleKey: "button.go.to.launch",
                            iconName: "play.fill"
                        )
                    } action: {
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                } else {
                    ProgressView {
                        Text("activity.loading")
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct FinishedActivityView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedActivityView()
    }
}
