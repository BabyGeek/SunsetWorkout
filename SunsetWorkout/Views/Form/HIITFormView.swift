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
            FloatingTextField(placeHolder: "\(SWMetadataType.roundBreak.label) (secs)",
                              text: $roundBreak,
                              bgColor: Color(.clear))
                .keyboardType(.numberPad)

            FloatingTextField(placeHolder: "\(SWMetadataType.roundNumber.label)",
                              text: $roundNumber,
                              bgColor: Color(.clear))
                .keyboardType(.numberPad)
        }
    }
}

struct HIITFormView_Previews: PreviewProvider {
    static var previews: some View {
        HIITFormView(roundBreak: .constant("10"), roundNumber: .constant("5"))
    }
}
