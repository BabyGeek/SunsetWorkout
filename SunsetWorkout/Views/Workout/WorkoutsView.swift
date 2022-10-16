//
//  WorkoutsView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/10/2022.
//

import SwiftUI
import RealmSwift

struct WorkoutsView: View {
    @ObservedObject var viewModel = WorkoutsViewModel()

    var body: some View {
        ScrollView {
            ForEach(viewModel.workouts) { workout in
                NavigationLink {
                    WorkoutView(workout: workout)
                } label: {
                    WorkoutCardView(workout: workout)
                        .foregroundColor(Color(.label))
                }
            }
        }
        .onAppear {
            viewModel.fetch(with: SWWorkout.allByDateASC)
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
