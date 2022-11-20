//
//  MainActivityView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/11/2022.
//

import SwiftUI

struct MainActivityView: View {
    @EnvironmentObject var viewModel: ActivityViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            if viewModel.activityStateIs(.running) {
                Text(viewModel.getCurrentExerciseName())
                    .font(.system(.title3))

                Text(viewModel.getCurrentRepetitionLocalizedString())
                    .padding(.top, 12)
            } else if viewModel.activityStateIs(.inBreak) {
                Text(NSLocalizedString("activity.in.break", comment: "In break label"))
                    .font(.title3)

                if viewModel.exerciseHasChanged {
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

            InputsView()
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(
            leading:
                HStack {
                    Button {
                        if !viewModel.activityStateIs(.initialized) {
                            viewModel.cancel()
                        }

                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                })
        .padding(.horizontal)
    }
}

struct MainActivityView_Previews: PreviewProvider {
    static var previews: some View {
        MainActivityView()
    }
}
