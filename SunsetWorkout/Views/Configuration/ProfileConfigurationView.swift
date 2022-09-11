//
//  ProfileConfigurationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import SwiftUI

struct ProfileConfigurationView: View {
    @State private var continueToFeeling: Bool = false
    @State var age = ""
    @State var height = ""
    @State var weight = ""

    var body: some View {
        VStack {
            Text("Configure your profile")
                .font(.largeTitle)
            Spacer()
            VStack(spacing: 50) {
                TextField("Your age", text: $age)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .overlay(Capsule()
                        .stroke(lineWidth: 1))
                TextField("Your height", text: $height)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .overlay(Capsule()
                        .stroke(lineWidth: 1))
                TextField("Your weight", text: $weight)
                    .frame(height: 50)
                    .padding(.horizontal)
                    .overlay(Capsule()
                        .stroke(lineWidth: 1))
            }
            Spacer()
            VStack {
                Button {
                    continueToFeeling = true
                } label: {
                    Text("Continue")
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                        .overlay(
                        Capsule()
                            .stroke(lineWidth: 1))
                }
                Button {
                    continueToFeeling = true
                } label: {
                    Text("Skip")
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                        .overlay(
                        Capsule()
                            .stroke(lineWidth: 1))
                }
            }

        }
        .padding()
        .navigate(to: FeelingConfigurationView(), when: $continueToFeeling)
    }
}

struct ProfileConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileConfigurationView()
    }
}
