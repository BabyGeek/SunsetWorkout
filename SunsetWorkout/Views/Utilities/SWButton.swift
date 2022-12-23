//
//  SWButton.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 28/10/2022.
//

import SwiftUI

struct SWButton<Content: View>: View {
    @ViewBuilder var content: Content
    var action: () -> Void
    var tint: Color?

    init(tint: Color? = nil, @ViewBuilder label: @escaping () -> Content, action: @escaping () -> Void) {
        self.content = label()
        self.action = action
        self.tint = tint
    }

    var body: some View {
        Button {
            action()
        } label: {
            content
                .frame(maxWidth: .infinity)
        }
        .tint(tint)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .controlSize(.regular)
    }
}

struct SWButtonWithIcon: View {
    let iconName: String

    var body: some View {
        Image(systemName: iconName)
            .resizable()
            .frame(width: 24, height: 24)
    }
}

struct SWButtonWithIconAndTitle: View {
    let titleKey: LocalizedStringKey
    let iconName: String

    var body: some View {
        HStack {
            Spacer()
            Text(titleKey)
                .font(.system(.callout))
            Spacer()
            Image(systemName: iconName)
                .resizable()
                .frame(width: 30, height: 30)
        }
    }
}

struct ActivityBeganButton: View {
    var body: some View {
        HStack {
            Spacer()
            Text("activity.start")
                .font(.system(.callout))
            Spacer()
            Image(systemName: "play.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
        }
    }
}

struct ActivityButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ActivityBeganButton()
        }
    }
}
