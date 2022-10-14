//
//  WorkoutViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/10/2022.
//

import SwiftUI
import RealmSwift

class WorkoutViewModel: ObservableObject {
    @Published var error: SWError?
    @Published var workout: SWWorkout?
    @Published var saved: Bool = false

    let realmManager = RealmManager()

    public func saveWorkout() {
        workout?.cleanMetadata()

        if let workout {
            save(model: workout, with: SWWorkoutModel.init)
        }
    }

    func save(model: SWWorkout, with reverseTransformer: (SWWorkout) -> SWWorkoutModel) {
        do {
            try realmManager.save(model: model, with: reverseTransformer)
            saved = true
        } catch {
            self.error = SWError(error: error)
        }
    }
}
