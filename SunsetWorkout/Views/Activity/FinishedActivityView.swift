//
//  FinishedActivityView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 13/11/2022.
//

import SwiftUI

struct FinishedActivityView: View {
    @EnvironmentObject var viewModel: ActivityViewModel
    @EnvironmentObject var navigationCoordinator: NavigationCoordinator
    @Environment(\.presentationMode) var presentationMode

    @State var goToSummary: Bool = false
    @State var goToWorkout: Bool = false

    var body: some View {
        VStack(spacing: 80) {
            if viewModel.saved, let summary = viewModel.activitySummary {
                SWButton(tint: .green) {
                    SWButtonWithIconAndTitle(
                        titleKey: "button.go.to.summary",
                        iconName: "calendar.badge.clock"
                    )
                } action: {
                    withAnimation {
                        navigationCoordinator
                            .showSummaryView(summary)
                    }
                }

                SWButton(tint: .yellow) {
                    SWButtonWithIconAndTitle(
                        titleKey: "button.go.to.workout",
                        iconName: "figure.strengthtraining.traditional"
                    )
                } action: {
                    withAnimation {
                        navigationCoordinator
                            .showWorkoutView(summary.workout)
                    }
                }

                SWButton(tint: .blue) {
                    SWButtonWithIconAndTitle(
                        titleKey: "button.go.to.launch",
                        iconName: "play.fill"
                    )
                } action: {
                    presentationMode.wrappedValue.dismiss()
                }
            } else {
                if viewModel.activityLastStateIs(.initialized) || viewModel.activityLastStateIs(.starting) {
                    SWButton(tint: .yellow) {
                        SWButtonWithIconAndTitle(
                            titleKey: "button.go.to.workout",
                            iconName: "figure.strengthtraining.traditional"
                        )
                    } action: {
                        withAnimation {
                            navigationCoordinator
                                .showWorkoutView(viewModel.activity.workout)
                        }
                    }

                    SWButton(tint: .blue) {
                        SWButtonWithIconAndTitle(
                            titleKey: "button.go.to.launch",
                            iconName: "play.fill"
                        )
                    } action: {
                        presentationMode.wrappedValue.dismiss()
                    }
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
