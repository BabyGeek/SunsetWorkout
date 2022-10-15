//
//  HIITFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 15/10/2022.
//

import SwiftUI

struct HIITFormView: View {
    @Binding var roundBreak: String
    @Binding var roundNumber: String

    var body: some View {
        VStack {
            FloatingTextField(placeHolder: "Round break (secs)", text: $roundBreak, bgColor: Color(.systemBackground))
                .keyboardType(.numberPad)

            FloatingTextField(placeHolder: "Round number", text: $roundNumber, bgColor: Color(.systemBackground))
                .keyboardType(.numberPad)
        }
    }
}

struct HIITFormView_Previews: PreviewProvider {
    static var previews: some View {
        HIITFormView(roundBreak: .constant("10"), roundNumber: .constant("5"))
    }
}
