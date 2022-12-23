//
//  ProgressBar.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 27/10/2022.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var progress: Float
    @Binding var progressShow: Float

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 40.0)
                .opacity(0.3)
                .foregroundColor(Color.purple)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 40.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.purple)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)

            Text(String(format: "%.0f", self.progressShow))
                .font(.largeTitle)
                .bold()
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: .constant(0.25), progressShow: .constant(5))
    }
}
