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
                

                ActivityButton {
                    ActivityButtonWithIconAndTitle(
                        titleKey: "button.go.to.summary",
                        iconName: "calendar.badge.clock",
                        color: .green
                    )
                } action: {
                    goToSummary = true
                }
            }
            
            NavigationLink(
                destination: WorkoutView(viewModel: WorkoutViewModel(workout: viewModel.activity.workout)),
                isActive: $goToWorkout) {
                EmptyView()
            }

            ActivityButton {
                ActivityButtonWithIconAndTitle(
                    titleKey: "button.go.to.workout",
                    iconName: "figure.strengthtraining.traditional",
                    color: .yellow
                )
            } action: {
                goToWorkout = true
            }

            ActivityButton {
                ActivityButtonWithIconAndTitle(
                    titleKey: "button.go.to.launch",
                    iconName: "play.fill",
                    color: .blue
                )
            } action: {
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct FinishedActivityView_Previews: PreviewProvider {
    static var previews: some View {
        FinishedActivityView()
    }
}
