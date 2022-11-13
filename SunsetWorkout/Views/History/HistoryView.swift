//
//  HistoryView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/11/2022.
//

import SwiftUI

struct HistoryView: View {
    let summary: SWActivitySummary
    @StateObject var viewModel: SummaryExerciseSelectionViewModel

    init(summary: SWActivitySummary) {
        self.summary = summary
        _viewModel = StateObject(wrappedValue: SummaryExerciseSelectionViewModel(summary: summary))
    }

    var body: some View {
        ZStack(alignment: .top) {
            BackgroundView()

            VStack {
                HStack {
                    HistoryMetaView(
                        iconName: "timer",
                        value: summary.duration.stringFromTimeInterval())
                    Spacer()
                    HistoryMetaView(
                        iconName: "flame.fill",
                        value: summary.totalEnergyBurnedQuantity.description)
                    Spacer()
                    HistoryMetaView(
                        iconName: "dumbbell.fill",
                        value: summary.type.name)
                }
                .padding()
                Spacer()

                Spacer()
                exerciseSelection
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationTitle(summary.title)
    }

    var exerciseSelection: some View {
        VStack {
            TabView(selection: $viewModel.selectedExercise) {
                if summary.type == .highIntensityIntervalTraining {
                    ForEach(summary.formattedInputsHIIT) { input in
                        if let firstInput = input.inputs.first {
                            HIITInputSummaryView(
                                inputs: input.inputs,
                                exerciseName: summary.getExerciseNameFromID(input.exerciseUUID),
                                selectedInput: firstInput
                            )
                            .tag(input.exerciseUUID)
                        }
                    }
                }

                if summary.type == .traditionalStrengthTraining {
                    Text(String(format: NSLocalizedString("summary.goal", comment: "Goal label"), summary.getGoal()))

                    ForEach(summary.formattedInputsStrength) { input in
                        if let firstInput = input.inputs.first {
                            StrengthInputSummaryView(
                                inputs: input.inputs,
                                exerciseName: summary.getExerciseNameFromID(input.exerciseUUID),
                                exerciseGoal: summary.getExerciseGoal(input.exerciseUUID),
                                selectedInput: firstInput
                            )
                            .tag(input.exerciseUUID)
                        }
                    }
                }
            }
            .animation(.easeOut)
            .transition(.scale)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .frame(height: 200)
        .overlay(
            Button(action: {
                viewModel.updateExerciseUp()
            }, label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.label))
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray)
                            .frame(width: 25, height: 20))
            })
            .padding(.trailing)
            .opacity(viewModel.canHaveNext() ? 1 : 0)
            .buttonStyle(PlainButtonStyle()),
            alignment: .topTrailing
        )
        .overlay(
            Button(action: {
                viewModel.updateExerciseDown()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(.label))
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray)
                            .frame(width: 25, height: 20))
            })
            .padding(.leading)
            .opacity(viewModel.canHavePrevious() ? 1 : 0)
            .buttonStyle(PlainButtonStyle()),
            alignment: .topLeading
        )
        .padding(.horizontal)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(
            summary: .init(
                workout: .getMockWithName(
                    "test",
                    type: .highIntensityIntervalTraining),
                type: .highIntensityIntervalTraining,
                inputs: [:],
                startDate: Date(),
                endDate: Date(),
                duration: .init(2026),
                totalEnergyBurned: 658,
                events: [],
                endedWithState: .canceled))
    }
}
