//
//  WorkoutsViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/10/2022.
//

import SwiftUI
import RealmSwift

class WorkoutsViewModel: ObservableObject {
    @Published var error: SWError?
    @Published var workouts: [SWWorkout] = [SWWorkout]()

    let realmManager = RealmManager()

    func fetch(with request: FetchRequest<[SWWorkout], SWWorkoutModel>) {
        do {
            self.workouts = try realmManager.fetch(with: request)
        } catch {
            self.error = SWError(error: error)
        }
    }
}
