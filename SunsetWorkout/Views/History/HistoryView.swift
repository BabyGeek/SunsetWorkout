//
//  HistoryView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/11/2022.
//

import SwiftUI

struct HistoryView: View {
    let summary: SWActivitySummary
    
    var body: some View {
        Text(summary.title)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(summary: .init(workout: .getMockWithName("test", type: .highIntensityIntervalTraining), type: .highIntensityIntervalTraining, inputs: [:], startDate: Date(), endDate: Date(), duration: .init(12400), totalEnergyBurned: 2300, events: []))
    }
}
