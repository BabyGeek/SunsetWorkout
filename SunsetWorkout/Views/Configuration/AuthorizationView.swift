//
//  AuthorizationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 24/08/2022.
//

import SwiftUI

struct AuthorizationView: View {
    @State private var healthKitIsAuthorized: Bool = false
    var body: some View {
        VStack {
            Text("Sunset Workout")

            Spacer()

            Text("""
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus.
Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor.
Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi.
Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat.
Duis semper.
""")

            Spacer()

            Button {
                print("ask for auth and go to next after auth")
                healthKitIsAuthorized = true
            } label: {
                Text("Allow HealthKit")
                    .overlay(
                        Capsule()
                            .stroke(lineWidth: 2)
                            .frame(width: 200, height: 50)
                    )
            }
        }
        .padding()
        .navigate(to: ProfileConfigurationView(), when: $healthKitIsAuthorized)
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
    }
}
