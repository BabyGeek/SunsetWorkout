//
//  FeelingViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 23/09/2022.
//

import SwiftUI
import RealmSwift

class FeelingViewModel: ObservableObject {
    @Published var error: SWError?
    @Published var feelings: [Feeling]?

    let realmManager = RealmManager()

    func save(model: Feeling, with reverseTransformer: (Feeling) -> FeelingEntity) {
        do {
            try realmManager.save(model: model, with: reverseTransformer)
        } catch {
            self.error = SWError(error: error)
        }
    }

    func fetch(with request: FetchRequest<[Feeling], FeelingEntity>) {
        do {
            self.feelings = try realmManager.fetch(with: request)
        } catch {
            self.error = SWError(error: error)
        }
    }

    func getLastFeeling() -> Feeling? {
        self.fetch(with: Feeling.allByDateASC)
        guard let feelings else { return nil }

        return feelings.last
    }
}
