//
//  ProfileConfigurationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import SwiftUI

struct ProfileConfigurationView: View {
    @StateObject var viewModel = ProfileConfigurationViewModel()
    @AppStorage("currentPage") var currenPage = 1

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
                    Text(NSLocalizedString("walkthrought.skip", comment: "Profile height"))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                }
            }

            Text(NSLocalizedString("walkthrought.profile.title", comment: "Walkthrought profile title"))
                .kerning(1.3)
                .font(.title3)
                .fontWeight(.semibold)

            UserProfileFormView(
                height: $viewModel.height,
                weight: $viewModel.weight,
                heightUnit: viewModel.heightUnit(),
                weightUnit: viewModel.weightUnit())
            .padding(.top, 140)

            Spacer(minLength: 100)

        }
        .padding()
        .background(Color.purple.ignoresSafeArea())
        .onAppear {
            viewModel.refreshValues()
        }
        .onDisappear {
            viewModel.saveValues()
        }
    }
}

// public extension UIViewController {
//    @objc func tapAction() { self.view.endEditing(true) }
//
//    @objc func addTapToDismissKeyBoard() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
//        tap.cancelsTouchesInView = true
//        self.view.addGestureRecognizer(tap)
//    }
// }

struct ProfileConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileConfigurationView()
    }
}
