//
//  InputsView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/11/2022.
//

import SwiftUI

struct InputsView: View {
    @EnvironmentObject var viewModel: ActivityViewModel

    var body: some View {
        VStack {
            HStack {
                if viewModel.waitForInput {
                    SWButton(tint: .yellow) {
                        SWButtonWithIcon(iconName: "pencil.and.ellipsis.rectangle")
                    } action: {
                        viewModel.presentSerieAlert = true
                        viewModel.prepareAddInput()
                        viewModel.getNext()
                        viewModel.setupTimer()
                    }
                }

                if viewModel.canSkip {
                    SWButton(tint: .blue) {
                        SWButtonWithIcon(iconName: "forward.fill")
                    } action: {
                        if viewModel.isTraditionalTraining && viewModel.activityStateIs(.running) {
                            viewModel.presentSerieAlert = true
                            viewModel.shouldSkip = true
                            viewModel.prepareAddInput()
                            viewModel.getNext()
                            viewModel.setupTimer()
                        } else {
                            viewModel.skip()
                        }
                    }
                    .animation(.easeIn, value: viewModel.canSkip)
                }
            }

            HStack {
                if viewModel.canAskForReplay {
                    SWButton(tint: .green) {
                        SWButtonWithIcon(iconName: "play.fill")
                    } action: {
                        withAnimation {
                            viewModel.play()
                        }
                    }
                    .animation(.easeIn, value: viewModel.canAskForReplay)
                }

                if viewModel.canAskForPause {
                    SWButton(tint: .orange) {
                        SWButtonWithIcon(iconName: "pause.fill")
                    } action: {
                        withAnimation {
                            viewModel.pause()
                        }
                    }
                    .animation(.easeIn, value: viewModel.canAskForPause)
                }

                SWButton(tint: .red) {
                    SWButtonWithIcon(iconName: "stop.fill")
                } action: {
                    if viewModel.isTraditionalTraining && viewModel.activityStateIs(.running) {
                        viewModel.prepareAddInput()
                        viewModel.presentSerieAlert = true
                        viewModel.shouldCancel = true
                    } else {
                        withAnimation {
                            viewModel.cancel()
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct InputsView_Previews: PreviewProvider {
    static var previews: some View {
        InputsView()
    }
}
