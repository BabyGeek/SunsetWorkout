//
//  HistoryView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/11/2022.
//

import SwiftUI

struct HistoryView: View {
    let summary: SWActivitySummary
    @ObservedObject var navigationCoordinator: NavigationCoordinator = .shared

    var body: some View {
        VStack {
            HStack {
                HistoryMetaView(
                    iconName: "timer",
                    value: summary.duration.stringFromTimeInterval())
                Spacer()
                HistoryMetaView(
                    iconName: "flame.fill",
                    value: summary.totalEnergyBurnedInt.description)
                Spacer()
                HistoryMetaView(
                    iconName: summary.type.iconName,
                    value: summary.type.name)
            }
            .padding()

            VStack {
                if summary.type == .traditionalStrengthTraining {
                    Text(String(
                        format: NSLocalizedString("summary.goal", comment: "Goal label"),
                        summary.getGoal()))
                        .padding(.horizontal)

                    InputListView(
                        exercises: summary.formattedInputsStrength,
                        inputsKeyPath: \.inputs,
                        inputTagKeyPath: \.exerciseUUID) { inputExercise in
                            Text(summary.getExerciseNameFromID(inputExercise.exerciseUUID))
                        } inputItemView: { (input, exerciseUUID) in
                            StrengthInputRowView(
                                input: input,
                                goal: summary.getExerciseGoal(exerciseUUID))
                        }
                }

                if summary.type == .highIntensityIntervalTraining {
                    InputListView(
                        exercises: summary.formattedInputsHIIT,
                        inputsKeyPath: \.inputs,
                        inputTagKeyPath: \.exerciseUUID) { inputExercise in
                            Text(summary.getExerciseNameFromID(inputExercise.exerciseUUID))
                        } inputItemView: { (input, _) in
                            HIITInputRowView(input: input)
                        }
                }
            }
        }
        .navigationTitle(summary.title)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    navigationCoordinator.selectionFromTabBarItem(.history)
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.left")
                        Text("button.back")
                    }
                }
            }

        }
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
