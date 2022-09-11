//
//  FeelingConfigurationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import SwiftUI

struct FeelingConfigurationView: View {
    @AppStorage("currentPage") var currenPage = 1
    @State var selected: Feeling?

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

            ForEach(Feeling.allCases, id: \.self) { feeling in
                FeelingListingView(selected: $selected, feeling: feeling)
                    .onTapGesture {
                        withAnimation {
                            selected = feeling
                        }
                    }
            }

            Spacer(minLength: 100)
        }
        .padding()
        .background(Color.purple.ignoresSafeArea())
    }
}

struct FeelingListingView: View {
    var selected: Binding<Feeling?>
    var feeling: Feeling
    var columns: [GridItem] = [
        .init(.fixed(64), spacing: 20, alignment: .trailing),
        .init(.flexible(), alignment: .leading),
        .init(.fixed(20), spacing: 10)
    ]

    var body: some View {
        LazyVGrid(columns: columns) {
            Text(feeling.relatedEmoji)
                .font(.system(size: 64))
            Text(feeling.relatedDescription)

            Text("\(Image(systemName: selected.wrappedValue == feeling ? "chevron.right.2" : "chevron.right"))")
        }
        .overlay(
        Capsule()
            .stroke()
        )
    }
}

struct FeelingConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        FeelingConfigurationView()
    }
}
