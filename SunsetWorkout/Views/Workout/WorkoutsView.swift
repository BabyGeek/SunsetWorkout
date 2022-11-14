//
//  WorkoutsView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/10/2022.
//

import SwiftUI
import RealmSwift

struct WorkoutsView: View {
    @StateObject var viewModel = WorkoutsViewModel()

    var body: some View {
        if viewModel.workouts.isEmpty {
            EmptyWorkoutView()
        } else {
            ScrollView {
                ForEach(viewModel.workouts) { workout in
                    NavigationLink {
                        WorkoutView(viewModel: WorkoutViewModel(workout: workout))
                    } label: {
                        WorkoutCardView(workout: workout)
                            .foregroundColor(Color(.label))
                    }
                    .padding(.bottom)
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
