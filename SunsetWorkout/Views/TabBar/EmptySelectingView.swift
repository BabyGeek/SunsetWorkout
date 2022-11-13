//
//  EmptySelectingView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 22/09/2022.
//

import SwiftUI

struct EmptySelectingView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("activity_blue")
                .resizable()
                .scaledToFit()
            Spacer()
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct EmptySelectingView_Previews: PreviewProvider {
    static var previews: some View {
        EmptySelectingView()
    }
}
#endif
