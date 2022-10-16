//
//  DashboardCardView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct DashboardCardView: View {
    var icon: Image = Image(systemName: "bed.double")
    var title: String = ""
    var value: String = ""

    var body: some View {
        GlassMorphicCard(content: {
            VStack {
                HStack {
                    icon
                    Text(title)
                }
                .padding()

                Text(value)
            }
        }, height: 150)
    }
}

struct DashboardCardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardCardView()
    }
}
