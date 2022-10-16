//
//  WorkoutCardView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct WorkoutCardView: View {
    var workout: SWWorkout

    var body: some View {
        GlassMorphicCard(content: {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text(workout.name)
                            Text(workout.type.name)
                        }

                        VStack(alignment: .leading) {
                            ForEach(workout.metadata) { meta in
                                HStack {
                                    Text(meta.type.label + ":")
                                    Text(meta.value.isEmpty ? "N/A" : meta.value)
                                }
                            }
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

struct WorkoutCardView_Previews: PreviewProvider {
    static let HIITExample = SWWorkout(name: "Test HIIT", type: .highIntensityIntervalTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "20"),
        SWMetadata(type: .roundBreak, value: "10"),
        SWMetadata(type: .roundNumber, value: "5")
    ])

    static let StrengthExample = SWWorkout(name: "Test Strength", type: .traditionalStrengthTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "120"),
        SWMetadata(type: .serieBreak, value: "60"),
        SWMetadata(type: .serieNumber, value: "6"),
        SWMetadata(type: .repetitionGoal, value: "12")
    ])

    static var previews: some View {
        ZStack {
            BackgroundView()

            ScrollView {
                WorkoutCardView(workout: HIITExample)
                WorkoutCardView(workout: StrengthExample)
                WorkoutCardView(workout: StrengthExample)
                WorkoutCardView(workout: HIITExample)
                WorkoutCardView(workout: StrengthExample)
                WorkoutCardView(workout: HIITExample)
                WorkoutCardView(workout: HIITExample)
                WorkoutCardView(workout: StrengthExample)
                WorkoutCardView(workout: StrengthExample)
                WorkoutCardView(workout: HIITExample)
            }
        }
    }
}
