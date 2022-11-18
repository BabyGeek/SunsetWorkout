//
//  HIITInputRowView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/11/2022.
//

import SwiftUI

struct HIITInputRowView: View {
    let input: ActivityHIITInput
    var body: some View {
        GlassMorphicCard(content: {
            VStack {
                HStack {
                    Text("input.round")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("\(input.round)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Text("input.time")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("\(String(format: "%.0f", input.timePassed))")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Text("input.skipped")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Image(systemName: input.skipped ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundColor(input.skipped ? .green : .red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }, height: 100)
    }
}

struct HIITInputRowView_Previews: PreviewProvider {
    static var previews: some View {
        HIITInputRowView(input: .init(round: 1, timePassed: 30, skipped: false))
    }
}
