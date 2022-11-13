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

struct ActivityButtonWithIcon: View {
    let iconName: String
    let color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(color)
            .opacity(0.8)
            .frame(height: 50)
            .overlay(
                Image(systemName: iconName)
                    .resizable()
                    .frame(width: 24, height: 24)
            )
            .foregroundColor(Color(.label))
    }
}

struct ActivityButtonWithIconAndTitle: View {
    let titleKey: LocalizedStringKey
    let iconName: String
    let color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(color)
            .opacity(0.8)
            .frame(height: 50)
            .overlay(
                HStack {
                    Spacer()
                    Text(titleKey)
                        .font(.system(.callout))
                    Spacer()
                    Image(systemName: iconName)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                    .padding(.horizontal)
            )
            .foregroundColor(Color(.label))
    }
}

struct ActivityButtonWithText: View {
    let label: LocalizedStringKey
    let color: Color

    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(color)
            .opacity(0.8)
            .frame(height: 50)
            .overlay(
                Text(label)
            )
            .foregroundColor(Color(.label))
    }
}

struct ActivityBeganButton: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(Color.green)
            .opacity(0.8)
            .frame(height: 50)
            .overlay(
                HStack {
                    Spacer()
                    Text("activity.start")
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
        }
    }
}
