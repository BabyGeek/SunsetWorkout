//
//  UserProfileFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 15/10/2022.
//

import SwiftUI

struct UserProfileFormView: View {
    @Binding var height: String
    @Binding var weight: String

    var heightUnit: String
    var weightUnit: String

    var body: some View {
        VStack(spacing: 30) {
            FloatingTextField(
                placeHolder: "\(NSLocalizedString("profile.height", comment: "Profile height")) (\(heightUnit))",
                text: $height, bgColor:
                        .purple)
            .keyboardType(.decimalPad)

            FloatingTextField(
                placeHolder: "\(NSLocalizedString("profile.weight", comment: "Profile height")) (\(weightUnit))",
                text: $weight, bgColor:
                        .purple)
            .keyboardType(.decimalPad)
        }
    }
}

struct UserProfileFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileFormView(height: .constant(""), weight: .constant(""), heightUnit: "meters", weightUnit: "kg")
    }
}
