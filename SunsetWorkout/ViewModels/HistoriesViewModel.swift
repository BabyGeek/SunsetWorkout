//
//  HistoriesViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/11/2022.
//

import SwiftUI
import RealmSwift

@MainActor class HistoriesViewModel: ObservableObject {
    @Published var error: SWError?
    @Published var summaries: [SWActivitySummary] = [SWActivitySummary]()

    var notificationToken: NotificationToken?

    let realmManager = RealmManager()

    init() {
        self.fetch(with: SWActivitySummary.allByDateDESC)

        if let realm = try? Realm() {
            self.notificationToken = realm.observe { [weak self] (_, _) in
                if let self {
                    self.fetch(with: SWActivitySummary.allByDateDESC)
                }
            }
        }
    }

    deinit {
        notificationToken?.invalidate()
    }

    func fetch(with request: FetchRequest<[SWActivitySummary], SWActivitySummaryEntity>) {
        do {
            self.summaries = try realmManager.fetch(with: request)
        } catch {
            self.error = SWError(error: error)
        }
    }
}
