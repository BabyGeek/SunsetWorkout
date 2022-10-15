//
//  FeelingConfigurationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import SwiftUI

struct FeelingConfigurationView: View {
    @AppStorage("currentPage") var currenPage = 1
    @State var selected: FeelingType = .happy

    @StateObject var feelingViewModel = FeelingViewModel()

    var feeling: Feeling {
        Feeling(type: selected)
    }

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

            Text(NSLocalizedString("walkthrought.feeling.title", comment: "Feeling walkthrought title"))
                .kerning(1.3)
                .font(.title3)

            feelingsList

            Spacer(minLength: 100)
        }
        .padding()
        .background(Color.purple.ignoresSafeArea())
        .onDisappear {
            feelingViewModel.save(model: feeling, with: FeelingModel.init)
        }
    }
}

extension FeelingConfigurationView {
    var feelingsList: some View {
        VStack {
            HStack {
                FeelingListingView(selected: $selected, feeling: FeelingType.happy)
                FeelingListingView(selected: $selected, feeling: FeelingType.sad)
            }
            HStack {
                FeelingListingView(selected: $selected, feeling: FeelingType.excited)
                FeelingListingView(selected: $selected, feeling: FeelingType.annoyed)
            }
            HStack {
                FeelingListingView(selected: $selected, feeling: FeelingType.tired)
                FeelingListingView(selected: $selected, feeling: FeelingType.stressed)
            }
        }
    }
}

struct FeelingListingView: View {
    @Binding var selected: FeelingType
    var feeling: FeelingType
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
