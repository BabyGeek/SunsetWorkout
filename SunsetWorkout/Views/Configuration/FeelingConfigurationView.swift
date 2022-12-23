//
//  FeelingConfigurationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import SwiftUI

struct FeelingConfigurationView: View {
    @AppStorage("currentPage", store: UserDefaults(suiteName: "defaults.com.poggero.SunsetWorkout")) var currentPage = 1
    @State var selected: FeelingType = .happy

    @StateObject var feelingViewModel = FeelingViewModel()

    var feeling: Feeling {
        Feeling(type: selected)
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    currentPage -= 1
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
                    currentPage = WalkthroughConfigurationSettings.totalPages + 1
                } label: {
                    Text("walkthrought.skip")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                }
            }

            Text("walkthrought.feeling.title")
                .kerning(1.3)
                .font(.title3)

            feelingsList

            Spacer(minLength: 100)
        }
        .padding()
        .background(Color.purple.ignoresSafeArea())
        .onDisappear {
            feelingViewModel.save(model: feeling, with: FeelingEntity.init)
        }
        .toastWithError($feelingViewModel.error)
    }
}

struct FeelingSelectionView: View {
    @Binding var selected: FeelingType

    var body: some View {
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

extension FeelingConfigurationView {
    var feelingsList: some View {
        FeelingSelectionView(selected: $selected)
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
                        K.Colors.cardGradientStart,
                        K.Colors.cardGradientMiddle,
                        K.Colors.cardGradientEnd
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

#if DEBUG
struct FeelingConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingConfigurationView()
    }
}
#endif
