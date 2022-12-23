//
//  ProfileConfigurationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import SwiftUI

struct ProfileConfigurationView: View {
    @StateObject var viewModel = ProfileConfigurationViewModel()
    @AppStorage("currentPage", store: UserDefaults(suiteName: "defaults.com.poggero.SunsetWorkout")) var currenPage = 1

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    currenPage -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(10)
                }

                Spacer()
                Button {
                    currenPage = WalkthroughConfigurationSettings.totalPages + 1
                } label: {
                    Text("walkthrought.skip")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                }
            }

                Text("walkthrought.profile.title")
                .kerning(1.3)
                .font(.title3)
                .fontWeight(.semibold)

            Spacer()

            UserProfileFormView(
                height: $viewModel.height,
                weight: $viewModel.weight,
                heightUnit: viewModel.heightUnit(),
                weightUnit: viewModel.weightUnit())

            Image("personal_blue")
                .resizable()
                .scaledToFit()

            Spacer()

        }
        .padding()
        .background(Color.purple.ignoresSafeArea())
        .onAppear {
            viewModel.refreshValues()
        }
        .onDisappear {
            viewModel.saveValues()
        }
        .toastWithError($viewModel.error)
    }
}

#if DEBUG
struct ProfileConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileConfigurationView()
    }
}
#endif
