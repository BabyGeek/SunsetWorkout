//
//  SummaryExerciseSelectionViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 13/11/2022.
//

import SwiftUI

class SummaryExerciseSelectionViewModel: ObservableObject {
    let summary: SWActivitySummary
    var previousIndex: Int = -1
    var selectedIndex: Int = 0
    var nextIndex: Int = 1

    @Published var previousExercise: String?
    @Published var selectedExercise: String
    @Published var nextExercise: String?

    init(summary: SWActivitySummary) {
        self.summary = summary
        self.selectedExercise = summary.workout.exercises.first?.id ?? ""
        if summary.workout.exercises.count > 1 {
            self.nextExercise = summary.workout.exercises[nextIndex].id
        }
    }

    func canHavePrevious() -> Bool {
        return selectedIndex > 0
    }

    func canHaveNext() -> Bool {
        if summary.type == .traditionalStrengthTraining {
            return nextIndex < summary.formattedInputsStrength.count
        }

        if summary.type == .highIntensityIntervalTraining {
            return nextIndex < summary.formattedInputsHIIT.count
        }

        return false
    }

    func updateExerciseUp() {
        DispatchQueue.main.async { [self] in
            previousExercise = summary.workout.exercises[selectedIndex].id
            selectedExercise = summary.workout.exercises[nextIndex].id

            previousIndex += 1
            selectedIndex += 1
            nextIndex += 1

            if summary.workout.exercises.indices.contains(nextIndex) {
                nextExercise = summary.workout.exercises[nextIndex].id
            } else {
                nextExercise = nil
            }
        }
    }

    func updateExerciseDown() {
        DispatchQueue.main.async { [self] in
            nextExercise = summary.workout.exercises[selectedIndex].id
            selectedExercise = summary.workout.exercises[previousIndex].id

            previousIndex -= 1
            selectedIndex -= 1
            nextIndex -= 1

            if summary.workout.exercises.indices.contains(previousIndex) {
                previousExercise = summary.workout.exercises[previousIndex].id
            } else {
                previousExercise = nil
            }
        }
    }
}
