//
//  WorkoutsView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/10/2022.
//

import SwiftUI

struct WorkoutsView: View {
    @StateObject var viewModel = WorkoutsViewModel()
    var body: some View {
        VStack {
            ForEach(viewModel.workouts, id: \.id) { workout in
                Text(workout.name)
            }
        }
        .onAppear {
            viewModel.fetch(with: SWWorkout.all)
        }

    }

}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
