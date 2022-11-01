//
//  ActivityHIITExercisePartialView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 29/10/2022.
//

import SwiftUI

struct ActivityHIITExercisePartialView: View {
    @Binding var timePassed: Float
    @Binding var timeRemaining: Float

    var body: some View {
        VStack {
            ProgressBar(
                progress: $timePassed,
                progressShow: $timeRemaining)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 350)
        }
    }
}

struct ActivityHIITExercisePartialView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityHIITExercisePartialView(timePassed: .constant(0.6), timeRemaining: .constant(3))
    }
}
