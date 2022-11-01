//
//  ActivityButton.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 28/10/2022.
//

import SwiftUI

struct ActivityButton<Content: View>: View {
    @ViewBuilder var content: Content
    var action: () -> Void

    init(@ViewBuilder label: @escaping () -> Content, action: @escaping () -> Void) {
        self.content = label()
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            content
        }

    }
}

struct ActivityPlayButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.green)
            .opacity(0.8)
            .frame(height: 50)
            .overlay(
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
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
                    .resizable()
                    .frame(width: 24, height: 24)
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
                    .resizable()
                    .frame(width: 24, height: 24)
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
                    Spacer()
                    Text(NSLocalizedString("activity.start", comment: "Start"))
                        .font(.system(.callout))
                    Spacer()
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                    .padding(.horizontal)
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
                ActivityPlayButton()
                ActivityStopButton()
            }
        }
    }
}
