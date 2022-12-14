//
//  WorkoutsViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/10/2022.
//

import SwiftUI
import RealmSwift

@MainActor class WorkoutsViewModel: ObservableObject {
    @Published var error: SWError?
    @Published var workouts: [SWWorkout] = [SWWorkout]()

    var notificationToken: NotificationToken?

    let realmManager = RealmManager()

    init() {
        self.fetch(with: SWWorkout.allByDateDESC)

        if let realm = try? Realm() {
            self.notificationToken = realm.observe { [weak self] (_, _) in
                if let self {
                    self.fetch(with: SWWorkout.allByDateDESC)
                }
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    func fetch(with request: FetchRequest<[SWWorkout], SWWorkoutEntity>) {
        do {
            self.workouts = try realmManager.fetch(with: request)
        } catch {
            self.error = SWError(error: error)
        }
    }
}
