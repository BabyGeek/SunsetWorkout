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
                Text("\(input.timePassed)")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack {
                Text("input.skipped")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Image(systemName: input.skipped ? "checkmark" : "xmark")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct HIITInputRowView_Previews: PreviewProvider {
    static var previews: some View {
        HIITInputRowView(input: .init(round: 1, timePassed: 30, skipped: false))
    }
}
