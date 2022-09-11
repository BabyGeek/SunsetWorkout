//
//  FeelingConfigurationView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 04/09/2022.
//

import SwiftUI

struct FeelingConfigurationView: View {
    @State var finishOnBoarding: Bool = false
    @State var selected: Feeling?

    var body: some View {
        VStack {
            Text("How are you feeling today?")
                .font(.title)
            Spacer()
            ForEach(Feeling.allCases, id: \.self) { feeling in
                FeelingListingView(selected: $selected, feeling: feeling)
                    .onTapGesture {
                        withAnimation {
                            selected = feeling
                        }
                    }
            }

            Spacer()

            if selected != nil {
                Button {
                    finishOnBoarding = true
                } label: {
                    Text("Continue")
                        .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                        .overlay(
                        Capsule()
                            .stroke(lineWidth: 1))
                }
            }

            Button {
                finishOnBoarding = true
            } label: {
                Text("Skip")
                    .frame(width: UIScreen.main.bounds.width - 20, height: 50)
                    .overlay(
                    Capsule()
                        .stroke(lineWidth: 1))
            }
        }
        .padding()
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
