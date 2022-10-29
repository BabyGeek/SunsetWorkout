//
//  ActivityButton.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 28/10/2022.
//

import SwiftUI

struct ActivityPlayButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.green)
            .opacity(0.8)
            .frame(height: 50)
            .overlay(
                Image(systemName: "play.fill")
            )
            .foregroundColor(Color(.label))
    }
}

struct ActivityPauseButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.orange)
            .opacity(0.8)
            .frame(height: 50)
            .overlay(
                Image(systemName: "pause.fill")
            )
            .foregroundColor(Color(.label))
    }
}

struct ActivityStopButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.red)
            .opacity(0.8)
            .frame(height: 50)
            .overlay(
                Image(systemName: "stop.fill")
            )
            .foregroundColor(Color(.label))
    }
}

struct ActivityBeganButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.green)
            .opacity(0.8)
            .frame(height: 50)
            .overlay(
                HStack {
                    Text(NSLocalizedString("activity.start", comment: "Start"))
                    Image(systemName: "play.fill")
                }
            )
            .foregroundColor(Color(.label))
    }
}

struct ActivityButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ActivityBeganButton()
            HStack {
                ActivityPauseButton()
                    .frame(width: 70)
                ActivityPlayButton()
                    .frame(width: 70)
                ActivityStopButton()
                    .frame(width: 70)
            }
        }
    }
}
