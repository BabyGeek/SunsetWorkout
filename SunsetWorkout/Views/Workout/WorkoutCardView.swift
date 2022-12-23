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
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack() {
                        Image(systemName: workout.type.iconName)
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text(workout.name)
                    }
                    
                    if !workout.metadata.filter({ !$0.value.isEmpty }).isEmpty {
                        HStack {
                            ForEach(workout.metadata.filter({ !$0.value.isEmpty })) { meta in
                                Spacer()
                                HStack(spacing: 10) {
                                    Image(systemName: meta.type.iconName)
                                        .resizable()
                                        .frame(width: 12, height: 12)
                                    
                                    Text(meta.value.isEmpty ? "N/A" : meta.value)
                                }
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 8, height: 8)
                    .foregroundColor(Color(.secondaryLabel))
            }
        }, height: 80)
    }
}

#if DEBUG
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
                VStack(spacing: 12) {
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
}
#endif
