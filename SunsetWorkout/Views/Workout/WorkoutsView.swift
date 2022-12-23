//
//  WorkoutsView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/10/2022.
//

import SwiftUI

struct WorkoutsView: View {
    @ObservedObject var viewModel = WorkoutsViewModel()

    var body: some View {
        if viewModel.workouts.isEmpty {
            EmptyWorkoutView()
        } else {
            ScrollView {
                
                VStack(spacing: 12) {
                    ForEach(viewModel.workouts) { workout in
                        NavigationLink {
                            WorkoutView(workout: workout)
                        } label: {
                            WorkoutCardView(workout: workout)
                                .foregroundColor(Color(.label))
                        }
                    }
                }
            }
            .toastWithError($viewModel.error)
        }
    }
}

#if DEBUG
struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
#endif
