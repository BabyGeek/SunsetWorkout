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
        if let realm = try? Realm() {
            let results = realm.objects(SWWorkoutEntity.self)
            self.notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
                if let self {
                    switch changes {
                    case .initial, .update:
                        self.fetch(with: SWWorkout.allByDateDESC)
                    case .error(let error):
                        self.error = SWError(error: error)
                    }
                }
            }
        } else {
            self.error = SWError(error: RealmError.noRealm)
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
