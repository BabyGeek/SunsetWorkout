//
//  EmptyHistoryView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/11/2022.
//

import SwiftUI

struct EmptyHistoryView: View {
    var body: some View {
        VStack {
            Spacer()

            Text("history.empty")
                .foregroundColor(Color(.label))

            Spacer()

            Image("happy_blue")
                .resizable()
                .scaledToFit()
        }
        .padding(.horizontal)
    }
}

struct EmptyHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyHistoryView()
    }
}
