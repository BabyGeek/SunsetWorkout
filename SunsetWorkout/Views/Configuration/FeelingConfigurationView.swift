//
//  FeelingConfigurationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import SwiftUI

struct FeelingConfigurationView: View {
    @AppStorage("currentPage") var currenPage = 1
    @State var selected: Feeling = .happy
    @StateObject var feelingViewModel = FeelingViewModel()

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

            Text("How are you feeling today?")
                .kerning(1.3)
                .font(.title3)

            feelingsList

            Spacer(minLength: 100)
        }
        .padding()
        .background(Color.purple.ignoresSafeArea())
        .onDisappear {
            feelingViewModel.saveFeeling(selected)
        }
    }
}

extension FeelingConfigurationView {
    var feelingsList: some View {
        VStack {
            HStack {
                FeelingListingView(selected: $selected, feeling: Feeling.happy)
                FeelingListingView(selected: $selected, feeling: Feeling.sad)
            }
            HStack {
                FeelingListingView(selected: $selected, feeling: Feeling.excited)
                FeelingListingView(selected: $selected, feeling: Feeling.annoyed)
            }
            HStack {
                FeelingListingView(selected: $selected, feeling: Feeling.tired)
                FeelingListingView(selected: $selected, feeling: Feeling.stressed)
            }
        }
    }
}

struct FeelingListingView: View {
    @Binding var selected: Feeling
    var feeling: Feeling
    var columns: [GridItem] = [
        .init(.fixed(64), spacing: 20, alignment: .trailing),
        .init(.flexible(), alignment: .leading),
        .init(.fixed(20), spacing: 10)
    ]
    var body: some View {
            RoundedRectangle(cornerRadius: 25)
                .fill(LinearGradient(
                    gradient: .init(colors: [
                        Colors.cardGradientStart,
                        Colors.cardGradientMiddle,
                        Colors.cardGradientEnd
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(height: 150)
                .overlay(
                    VStack(alignment: .center) {
                        Text(feeling.shortName)
                        Text(feeling.relatedEmoji)
                            .font(.system(size: 64))
                        Text(feeling.relatedDescription)
                    }
                )
                .onTapGesture {
                    withAnimation {
                        selected = feeling
                    }
                }
                .shadow(color: .white.opacity(selected == feeling ? 1 : 0), radius: 10)

    }
}

struct FeelingConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingConfigurationView()
    }
}
