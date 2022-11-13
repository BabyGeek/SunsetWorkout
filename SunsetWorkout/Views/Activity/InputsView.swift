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
                    ActivityButton {
                        ActivityButtonWithIcon(
                            iconName: "pencil.and.ellipsis.rectangle",
                            color: .yellow
                        )
                    } action: {
                        viewModel.presentSerieAlert = true
                        viewModel.prepareAddInput()
                        viewModel.getNext()
                        viewModel.setupTimer()
                    }
                }

                if viewModel.canSkip {
                    ActivityButton {
                        ActivityButtonWithIcon(
                            iconName: "forward.fill",
                            color: .blue
                        )
                    } action: {
                        viewModel.skip()
                    }
                }
            }

            HStack {
                if viewModel.canAskForReplay {
                    ActivityButton {
                        ActivityButtonWithIcon(
                            iconName: "play.fill",
                            color: .green
                        )
                    } action: {
                        viewModel.play()
                    }
                }

                if viewModel.canAskForPause {
                    ActivityButton {
                        ActivityButtonWithIcon(
                            iconName: "pause.fill",
                            color: .orange
                        )
                    } action: {
                        viewModel.pause()
                    }
                }

                ActivityButton {
                    ActivityButtonWithIcon(
                        iconName: "stop.fill",
                        color: .red
                    )
                } action: {
                    viewModel.cancel()
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
