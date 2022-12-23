//
//  TraditionalFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 15/10/2022.
//

import SwiftUI

struct TraditionalFormView: View {
    @Binding var seriesBreak: String
    @Binding var seriesNumber: String
    @Binding var repetitionGoal: String

    var body: some View {
        Section {
            FloatingTextField(
                placeHolder: SWMetadataType.serieBreak.label,
                placeHolderSuffix: "secs",
                text: $seriesBreak,
                bgColor: Color(.clear)) {
                    Text(SWMetadataType.serieBreak.label)
                }
                .keyboardType(.numberPad)

            FloatingTextField(
                placeHolder: SWMetadataType.serieNumber.label,
                text: $seriesNumber,
                bgColor: Color(.clear)) {
                    Text(SWMetadataType.serieNumber.label)
                }
                .keyboardType(.numberPad)

            FloatingTextField(
                placeHolder: SWMetadataType.repetitionGoal.label,
                text: $repetitionGoal,
                bgColor: Color(.clear)) {
                    Text(SWMetadataType.repetitionGoal.label)
                }
                .keyboardType(.numberPad)
        }
    }
}

#if DEBUG
struct TraditionalFormView_Previews: PreviewProvider {
    static var previews: some View {
        TraditionalFormView(seriesBreak: .constant("60"), seriesNumber: .constant("6"), repetitionGoal: .constant("12"))
    }
}
#endif
