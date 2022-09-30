//
//  DashboardView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/09/2022.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var dashboardViewModel = DashboardViewModel()
    @State private var lastHostingView: UIView!

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
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
                        if let quote = dashboardViewModel.quote {
                            Text("\(quote.author) said:")
                            HStack(alignment: .top) {
                                Image(systemName: "quote.opening")
                                    .frame(maxHeight: 100, alignment: .top)

                                Text(quote.content)
                                .font(.italic(.body)())
                                .frame(maxHeight: 100)

                                Image(systemName: "quote.closing")
                                    .frame(maxHeight: 100, alignment: .bottom)
                            }
                            .padding(.horizontal)
                            Text(quote.getTagsFormatted())
                                .font(.italic(.caption)())
                        }
                    }
                }

                HStack {
                    DashboardCardView(
                        icon: Image(systemName: "bed.double"),
                        title: "Sleep",
                        value: dashboardViewModel.getSleptLabel())
                    DashboardCardView(
                        icon: Image(systemName: "leaf"),
                        title: "Feeling",
                        value: Feeling.happy.relatedEmoji)
                }

                HStack {
                    DashboardCardView(
                        icon: Image(systemName: "figure.walk"),
                        title: "Move",
                        value: dashboardViewModel.dailyKilocalories.description)
                    DashboardCardView(
                        icon: Image(systemName: "bolt"),
                        title: "Training",
                        value: dashboardViewModel.dailyTrainedTime.description)
                }
            }
            .padding()
            .navigationBarItems(trailing:
                                    Button(action: {
                                        print("profile tapped")
                                    }, label: {
                                        ProfileView()
                                    }))
            .navigationTitle("Title")
            .onAppear {
                dashboardViewModel.getUpdatedValues()
            }
        }
    }
}

struct ProfileView: View {
    var body: some View {
        Image("Profile")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
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
