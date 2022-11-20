//
//  StrengthInputRowView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/11/2022.
//

import SwiftUI

struct StrengthInputRowView: View {
    let input: ActivityStrengthInput
    let goal: Int

    var body: some View {
        GlassMorphicCard(content: {
            VStack {
                HStack {
                    Text("input.serie")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("\(input.serie)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Text("input.repetitions")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text(input.repetitions)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack {
                    Text("input.goal")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("\(goal)")
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

struct StrengthInputRowView_Previews: PreviewProvider {
    static var previews: some View {
        StrengthInputRowView(input: .init(serie: 1, repetitions: "11", skipped: false), goal: 12)
    }
}
