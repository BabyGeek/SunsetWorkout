//
//  AuthorizationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 24/08/2022.
//

import SwiftUI

struct AuthorizationView: View {
    @AppStorage("currentPage") var currenPage = 1
    var body: some View {
        VStack(spacing: 20) {
            Text("Sunset Workout")
                .kerning(1.5)
                .font(.title)
                .fontWeight(.semibold)

            Spacer(minLength: 50)

            Text("""
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus.
Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor.
Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi.
Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat.
Duis semper.
""")
            .kerning(1.3)
            .font(.body)
            .multilineTextAlignment(.center)

            Spacer(minLength: 100)
        }
        .background(Color.yellow.ignoresSafeArea())
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
