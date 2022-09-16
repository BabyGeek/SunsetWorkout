//
//  ConfigurationWalkthrough.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/09/2022.
//

import SwiftUI

struct WalkthroughConfigurationSettings {
    static let totalPages = 3
    static let bgColorScreen1 = ""
    static let bgColorScreen2 = ""
    static let bgColorScreen3 = ""
}

struct ConfigurationWalkthroughView: View {
    @State var SWHealthStoreManager: SWHealthStoreManager
    @AppStorage("currentPage") var currentPage = 1

    var body: some View {
        ZStack {
            if currentPage == 1 {
                AuthorizationView()
                    .transition(.scale)
            }
            if currentPage == 2 {
                ProfileConfigurationView()
                    .transition(.scale)
            }

            if currentPage == 3 {
                FeelingConfigurationView()
                    .transition(.scale)
            }
        }
        .environmentObject(SWHealthStoreManager)
        .overlay(
            Button {
                withAnimation(.easeInOut) {
                    if currentPage <= WalkthroughConfigurationSettings.totalPages {
                        currentPage += 1
                    } else {
                        // only for test
                        currentPage = 1
                    }
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 29, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(
                        ZStack {
                            Circle()
                                .stroke(Color.black.opacity(0.04), lineWidth: 4)

                            Circle()
                                .trim(from: 0,
                                      to: CGFloat(currentPage) / CGFloat(WalkthroughConfigurationSettings.totalPages))
                                .stroke(Color.white, lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                            .padding(-15)
                    )
                    .opacity(SWHealthStoreManager.isWaiting ? 0 : 1)
            }
            .padding(.bottom, 20)

            , alignment: .bottom)
    }
}

struct ConfigurationWalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationWalkthroughView(SWHealthStoreManager: SWHealthStoreManager())
    }
}
