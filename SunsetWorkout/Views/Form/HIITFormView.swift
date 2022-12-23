//
//  HIITFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 15/10/2022.
//

import SwiftUI

struct HIITFormView: View {
    @Binding var roundBreak: String
    @Binding var roundDuration: String
    @Binding var roundNumber: String

    var body: some View {
        Section {
            FloatingTextField(placeHolder: SWMetadataType.roundBreak.label,
                              placeHolderSuffix: "secs",
                              text: $roundBreak,
                              bgColor: Color(.clear)) {
                Text(SWMetadataType.roundBreak.label)
            }
                .keyboardType(.numberPad)

            FloatingTextField(placeHolder: SWMetadataType.roundDuration.label,
                              placeHolderSuffix: "secs",
                              text: $roundDuration,
                              bgColor: Color(.clear)) {
                Text(SWMetadataType.roundDuration.label)
            }
            .keyboardType(.numberPad)

            FloatingTextField(placeHolder: SWMetadataType.roundNumber.label,
                              text: $roundNumber,
                              bgColor: Color(.clear)) {
                Text(SWMetadataType.roundNumber.label)
            }
                .keyboardType(.numberPad)
        }
    }
}

#if DEBUG
struct HIITFormView_Previews: PreviewProvider {
    static var previews: some View {
        HIITFormView(roundBreak: .constant("10"), roundDuration: .constant("30"), roundNumber: .constant("5"))
    }
}
#endif
