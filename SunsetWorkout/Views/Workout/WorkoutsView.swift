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
        List {
            ForEach(viewModel.workouts) { workout in
                Text(workout.name)
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
