//
//  HIITInputSummaryView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/11/2022.
//

import SwiftUI

struct HIITInputSummaryView: View {
    let inputs: [ActivityHIITInput]

    var body: some View {
        ScrollView {
            ForEach(inputs) { input in
                HIITInputRowView(input: input)
            }
        }
    }
}

struct HIITInputSummaryView_Previews: PreviewProvider {
    static let HIITInputs = [
        ActivityHIITInput(round: 1, timePassed: 30, skipped: false),
        ActivityHIITInput(round: 2, timePassed: 30, skipped: false),
        ActivityHIITInput(round: 3, timePassed: 30, skipped: false),
        ActivityHIITInput(round: 4, timePassed: 30, skipped: false),
        ActivityHIITInput(round: 5, timePassed: 25, skipped: true)
    ]

    static var previews: some View {
        HIITInputSummaryView(inputs: HIITInputs)
    }
}
