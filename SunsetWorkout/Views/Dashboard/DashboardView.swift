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
        VStack(alignment: .leading) {
            GlassMorphicCard(content: {
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
            }, height: 180)

            Spacer()

            VStack(spacing: 20) {
                HStack {
                    DashboardCardView(
                        icon: Image(systemName: "bed.double"),
                        title: NSLocalizedString("dashboard.sleep", comment: "Sleep title"),
                        value: dashboardViewModel.getSleptLabel())
                    DashboardCardView(
                        icon: Image(systemName: "leaf"),
                        title: NSLocalizedString("dashboard.feeling", comment: "Feeling title"),
                        value: (
                            dashboardViewModel.feeling != nil) ?
                        dashboardViewModel.feeling!.type.relatedEmoji : "N/A")
                }

                HStack {
                    DashboardCardView(
                        icon: Image(systemName: "figure.walk"),
                        title: NSLocalizedString("dashboard.move", comment: "Move title"),
                        value: dashboardViewModel.dailyKilocalories.description)
                    DashboardCardView(
                        icon: Image(systemName: "bolt"),
                        title: NSLocalizedString("dashboard.training", comment: "Training title"),
                        value: dashboardViewModel.dailyTrainedTime.description)
                }
            }
        }
        .onAppear {
            dashboardViewModel.getUpdatedValues()
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

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
