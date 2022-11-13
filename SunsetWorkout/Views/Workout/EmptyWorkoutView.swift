//
//  EmptyWorkoutView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 30/10/2022.
//

import SwiftUI

struct EmptyWorkoutView: View {
    var body: some View {
        VStack {
            Spacer()

            Text("workout.add.first")
                .foregroundColor(Color(.label))

            Spacer()

            Image("goal_blue")
                .resizable()
                .scaledToFit()
        }
        .padding(.horizontal)
    }
}
struct EmptyWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyWorkoutView()
    }
}
