//
//  HistoryCardView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/11/2022.
//

import SwiftUI

struct HistoryCardView: View {
    let summary: SWActivitySummary

    var body: some View {
        GlassMorphicCard(content: {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text(summary.title)
                        }

                        VStack(alignment: .leading) {
                            HistoryMetaView(
                                iconName: "timer",
                                value: summary.duration.stringFromTimeInterval())
                            HistoryMetaView(
                                iconName: "flame.fill",
                                value: summary.totalEnergyBurnedQuantity.description)
                            HistoryMetaView(
                                iconName: "dumbbell.fill",
                                value: summary.type.name)
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 18, height: 18)
                }
            }
        }, height: 150)
    }
}

struct HistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCardView(
            summary: .init(
                workout: .getMockWithName(
                    "test",
                    type: .highIntensityIntervalTraining),
                type: .highIntensityIntervalTraining,
                inputs: [:],
                startDate: Date(),
                endDate: Date(),
                duration: .init(12400),
                totalEnergyBurned: 2300,
                events: [],
                endedWithState: .finished))
    }
}
