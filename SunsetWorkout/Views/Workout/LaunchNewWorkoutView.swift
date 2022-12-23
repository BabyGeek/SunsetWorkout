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
        if viewModel.workouts.isEmpty {
            EmptyWorkoutView()
        } else {
            ScrollView {
                ForEach(viewModel.workouts) { workout in
                    NavigationLink {
                        ActivityView(workout: workout)
                    } label: {
                        GlassMorphicCard(content: {
                            HStack {
                                Text(workout.name)
                                    .foregroundColor(Color(.label))
                                Spacer()
                                HStack {
                                    Image(systemName: "timer")
                                        .foregroundColor(Color(.label))
                                    Text("\(workout.estimatedTime()) min")
                                        .foregroundColor(Color(.label))
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(Color(.secondaryLabel))
                            }
                        }, height: 50)
                    }

                }
            }
            .toastWithError($viewModel.error)
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
