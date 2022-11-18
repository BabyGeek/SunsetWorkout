//
//  HistoryView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/11/2022.
//

import SwiftUI

struct HistoryView: View {
    let summary: SWActivitySummary

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
                exerciseSelection
                    .edgesIgnoringSafeArea(.bottom)
            }
            .padding(.horizontal)
        }
        .navigationTitle(summary.title)
    }

    var exerciseSelection: some View {
        TabView {
                if summary.type == .highIntensityIntervalTraining {
                    ForEach(summary.formattedInputsHIIT) { input in
                        VStack {
                            Text(summary.getExerciseNameFromID(input.exerciseUUID))
                            HIITInputSummaryView(
                                inputs: input.inputs
                            )
                        }
                        .tag(input.exerciseUUID)
                    }
                }

                if summary.type == .traditionalStrengthTraining {
                    Text(String(format: NSLocalizedString("summary.goal", comment: "Goal label"), summary.getGoal()))

                    ForEach(summary.formattedInputsStrength) { input in
                        VStack {
                            Text(summary.getExerciseNameFromID(input.exerciseUUID))
                            StrengthInputSummaryView(
                                inputs: input.inputs,
                                exerciseGoal: summary.getExerciseGoal(input.exerciseUUID)
                            )
                            .tag(input.exerciseUUID)
                        }
                    }
                }
        }
        .frame(maxHeight: 650)
        .animation(.easeOut)
        .transition(.scale)
        .tabViewStyle(PageTabViewStyle())
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
