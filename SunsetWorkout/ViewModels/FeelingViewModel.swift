//
//  FeelingViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 23/09/2022.
//

import SwiftUI
import CloudKit

class FeelingViewModel: ObservableObject {

    func saveFeeling(_ feeling: Feeling) {
        let json: [String: Any] = [
            "created_at": Date(),
            "feeling": feeling
        ]
        
        

        dump(json)
    }
}
