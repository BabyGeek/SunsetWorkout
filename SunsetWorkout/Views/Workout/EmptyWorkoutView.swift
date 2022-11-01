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

            Text(NSLocalizedString("workout.add.first", comment: "Label to create first workout"))
                .foregroundColor(Color(.label))

            Spacer()

            Image("goal_blue")
                .resizable()
                .scaledToFit()
        }
    }
}
struct EmptyWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyWorkoutView()
    }
}
