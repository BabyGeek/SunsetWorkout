//
//  ActivityStrengthExercisePartialView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 29/10/2022.
//

import SwiftUI

struct ActivityStrengthExercisePartialView: View {
    @StateObject var viewModel: ActivityViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ActivityStrengthExercisePartialView_Previews: PreviewProvider {
    static let StrengthExample = SWWorkout(name: "Test Strength", type: .traditionalStrengthTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "120"),
        SWMetadata(type: .serieBreak, value: "60"),
        SWMetadata(type: .serieNumber, value: "6"),
        SWMetadata(type: .repetitionGoal, value: "12")
    ])

    static var previews: some View {
        ActivityStrengthExercisePartialView(viewModel: .init(workout: StrengthExample))
    }
}
