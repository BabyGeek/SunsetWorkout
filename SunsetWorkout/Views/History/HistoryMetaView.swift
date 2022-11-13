//
//  HistoryMetaView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/11/2022.
//

import SwiftUI

struct HistoryMetaView: View {
    let iconName: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
            Text(value)
        }
    }
}

struct HistoryMetaView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryMetaView(iconName: "fire.circle", value: "34")
    }
}
