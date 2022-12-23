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
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: "clock.badge.checkmark")
                            .foregroundColor(summary.endedWithState == .canceled ? .red : .green)
                        Text(summary.title)
                    }

                    HStack {
                        HistoryMetaView(
                            iconName: "timer",
                            value: summary.duration.stringFromTimeInterval())
                        Spacer()
                        HistoryMetaView(
                            iconName: "flame.fill",
                            value: summary.totalEnergyBurnedInt.description)
                        Spacer()
                        HistoryMetaView(
                            iconName: summary.type.iconName,
                            value: "")
                    }
                }
                .padding(.trailing)
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 8, height: 8)
                    .foregroundColor(Color(.secondaryLabel))
            }
        }, height: 100)
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
