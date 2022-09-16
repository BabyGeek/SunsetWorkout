//
//  ProfileConfigurationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import SwiftUI

struct ProfileConfigurationView: View {
    @State var profileConfigurationViewModel = ProfileConfigurationViewModel()
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
                    Text("Skip")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                }
            }

            Text("Configure your profile")
                .kerning(1.3)
                .font(.title3)
                .fontWeight(.semibold)

            VStack(spacing: 50) {

                FloatingTextField(
                    placeHolder: "Age",
                    text: $profileConfigurationViewModel.age, bgColor:
                        .blue)
                .keyboardType(.numberPad)

                FloatingTextField(
                    placeHolder: "Height (\(profileConfigurationViewModel.getUserLocaleHeightUnit()))",
                    text: $profileConfigurationViewModel.height, bgColor:
                        .blue)
                .keyboardType(.decimalPad)

                FloatingTextField(
                    placeHolder: "Weight (\(profileConfigurationViewModel.getUserLocaleWeightUnit()))",
                    text: $profileConfigurationViewModel.weight, bgColor:
                        .blue)
                .keyboardType(.decimalPad)
            }

            Spacer(minLength: 100)

        }
        .padding()
        .background(Color.blue.ignoresSafeArea())
        .onAppear {
            profileConfigurationViewModel.refreshValues()
        }
        .onDisappear {
            profileConfigurationViewModel.saveValues()
        }
    }
}

struct FloatingTextField: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: String
    @Binding var text: String
    private let bgColor: Color
    @State private var isEditing = false

    public init(placeHolder: String,
                text: Binding<String>, bgColor: Color) {
        self._text = text
        self.placeHolderText = placeHolder
        self.bgColor = bgColor
    }

    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text, onEditingChanged: { (edit) in
                isEditing = edit
            })
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondary, lineWidth: 1)
                .frame(height: textFieldHeight))
            .foregroundColor(Color.primary)
            .accentColor(Color.secondary)
            .animation(.linear)
            Text(placeHolderText)
                .foregroundColor(Color.secondary)
                .background(bgColor)
                .padding(shouldPlaceHolderMove ?
                         EdgeInsets(top: 0, leading: 15, bottom: textFieldHeight, trailing: 0) :
                            EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
                .scaleEffect(shouldPlaceHolderMove ? 1.0 : 1.2)
                .animation(.linear)
        }
    }
}

struct ProfileConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileConfigurationView()
    }
}
