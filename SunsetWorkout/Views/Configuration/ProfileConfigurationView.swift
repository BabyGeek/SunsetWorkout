//
//  ProfileConfigurationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import SwiftUI

struct ProfileConfigurationView: View {
    @AppStorage("currentPage") var currenPage = 1
    @State var age = ""
    @State var height = ""
    @State var weight = ""

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    currenPage -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(10)
                }

                Spacer()
                Button {
                    currenPage = WalkthroughConfigurationSettings.totalPages + 1
                } label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                }
            }

            Text("Configure your profile")
                .kerning(1.3)
                .font(.title3)
                .fontWeight(.semibold)

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

            Spacer(minLength: 100)

        }
        .padding()
        .background(Color.blue.ignoresSafeArea())
    }
}

struct ProfileConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileConfigurationView()
    }
}
