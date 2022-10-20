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
        VStack {
            FloatingTextField(
                placeHolder: "\(SWMetadataType.serieBreak.label) (secs)",
                text: $seriesBreak,
                bgColor: Color(.clear))
                .keyboardType(.numberPad)

            FloatingTextField(
                placeHolder: "\(SWMetadataType.serieNumber.label)",
                text: $seriesNumber,
                bgColor: Color(.clear))
                .keyboardType(.numberPad)

            FloatingTextField(
                placeHolder: "\(SWMetadataType.repetitionGoal.label)",
                text: $repetitionGoal,
                bgColor: Color(.clear))
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
