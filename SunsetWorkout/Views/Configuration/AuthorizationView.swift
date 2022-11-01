//
//  AuthorizationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 24/08/2022.
//

import SwiftUI

struct AuthorizationView: View {
    @EnvironmentObject var SWHealthStoreManager: SWHealthStoreManager
    @AppStorage("currentPage") var currenPage = 1
    var withButton: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text("app.title")
                .kerning(1.5)
                .font(.title)
                .fontWeight(.semibold)

            Image("tracker_blue")
                .resizable()
                .scaledToFit()

            Text(NSLocalizedString(
                "walkthrought.healthkit.information",
                comment: "Description of why the app needs HealthKit authorization"))

            .kerning(1.3)
            .font(.body)
            .multilineTextAlignment(.center)

            Spacer(minLength: 100)

            if withButton {
                Button {
                    SWHealthStoreManager.askForPermission { (success) in
                        print(success)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 50)
                        .overlay(
                            Text(NSLocalizedString(
                                "walkthrought.healthkit.authorize"
                                , comment: "Authorize button title"))
                            .foregroundColor(Color(.label))
                        )
                }
            }
        }
        .padding()
        .background(Color.purple.ignoresSafeArea())
    }
}

#if DEBUG
struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView(withButton: true)
            .preferredColorScheme(.dark)
    }
}
#endif
