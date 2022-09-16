//
//  DashboardView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/09/2022.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.largeTitle)

            ZStack {
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
                    .frame(height: 180)

                VStack {
                    Text("Carl Lewis said:")
                    HStack(alignment: .top) {
                        Image(systemName: "quote.opening")
                            .frame(maxHeight: 100, alignment: .top)

                        Text("Life is about timing.")
                        .font(.italic(.body)())
                        .frame(maxHeight: 100)

                        Image(systemName: "quote.closing")
                            .frame(maxHeight: 100, alignment: .bottom)
                    }
                    .padding(.horizontal)
                    Text("Sports, competition")
                        .font(.italic(.caption)())
                }
            }

            HStack {
                DashboardCardView(
                    icon: Image(systemName: "bed.double"),
                    title: "Sleep",
                    value: "8 h")
                DashboardCardView(
                    icon: Image(systemName: "leaf"),
                    title: "Feeling",
                    value: Feeling.happy.relatedEmoji)
            }

            HStack {
                DashboardCardView(
                    icon: Image(systemName: "figure.walk"),
                    title: "Move",
                    value: "558 kcal")
                DashboardCardView(
                    icon: Image(systemName: "bolt"),
                    title: "Training",
                    value: "45 min")
            }
        }
        .padding()
    }
}

struct DashboardCardView: View {
    var icon: Image = Image(systemName: "bed.double")
    var title: String = ""
    var value: String = ""

    var body: some View {
        ZStack {
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
                .frame(height: 180)

            VStack {
                HStack {
                    icon
                    Text(title)
                }
                .padding()

                Text(value)
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
