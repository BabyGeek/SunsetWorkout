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
    let realmManager = RealmManager()

    func saveFeeling(_ feeling: Feeling) {
        let feelingModel: FeelingModel = FeelingModel(
            createdAt: Date(),
            rawFeeling: feeling.rawValue
        )

        do {
            try realmManager.saveObject(feelingModel)
        } catch {
            self.error = SWError(error: error)
        }
    }

    func getFeelings() -> Results<FeelingModel>? {
        var feelings: Results<FeelingModel>?

        do {
            feelings = try realmManager.getObjects(FeelingModel.self)
        } catch {
            self.error = SWError(error: error)
        }

        return feelings
    }

    func getLastFeeling() -> FeelingModel? {
        guard let feelings = getFeelings() else { return nil }
        return feelings.last
    }
}
