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

    let realmManager = RealmManager()

    public func saveWorkout() {
        workout?.cleanMetadata()

        if let workout {
            save(model: workout, with: SWWorkoutMetadataModel.init)
        }
    }

    func save<Model, RealmObject: Object>(model: Model, with reverseTransformer: (Model) -> RealmObject) {
        let object = reverseTransformer(model)

        do {
            try realmManager.saveObject(object)
            print("done")
        } catch {
            self.error = SWError(error: error)
        }
    }
}
