//
//  LaunchNewWorkoutView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 22/09/2022.
//

import SwiftUI

struct LaunchNewWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = WorkoutsViewModel()

    var body: some View {
        ScrollView {
            ForEach(viewModel.workouts) { workout in
                NavigationLink {
                    ActivityView(workout: workout)
                } label: {
                    GlassMorphicCard(content: {
                        HStack {
                            Text(workout.name)
                            Spacer()
                            Image(systemName: "timer")
                            Text("\(workout.estimatedTime()) min")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(Color(.label))
                    }, height: 80)
                }

            }
        }
    }
}

#if DEBUG
struct LaunchNewWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchNewWorkoutView()
    }
}
#endif
