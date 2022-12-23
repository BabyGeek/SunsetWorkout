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
            FloatingTextField<EmptyView>(
                placeHolder: "profile.height",
                placeHolderSuffix: heightUnit,
                text: $height,
                bgColor: .purple)
            .keyboardType(.decimalPad)

            FloatingTextField<EmptyView>(
                placeHolder: "profile.weight",
                placeHolderSuffix: weightUnit,
                text: $weight,
                bgColor: .purple)
            .keyboardType(.decimalPad)
        }
    }
}

#if DEBUG
struct UserProfileFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileFormView(height: .constant(""), weight: .constant(""), heightUnit: "meters", weightUnit: "kg")
    }
}
#endif
