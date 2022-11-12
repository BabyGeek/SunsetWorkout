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
                .frame(maxHeight: 80)

            VStack(spacing: 20) {
                HStack {
                    DashboardCardView(
                        icon: Image(systemName: "bed.double"),
                        title: "dashboard.sleep",
                        value: dashboardViewModel.getSleptLabel())
                    DashboardCardView(
                        icon: Image(systemName: "leaf"),
                        title: "dashboard.feeling",
                        value: (
                            dashboardViewModel.feeling != nil) ?
                        dashboardViewModel.feeling!.type.relatedEmoji : "N/A")
                }

                HStack {
                    DashboardCardView(
                        icon: Image(systemName: "figure.walk"),
                        title: "dashboard.move",
                        value: dashboardViewModel.dailyKilocalories.description)
                    DashboardCardView(
                        icon: Image(systemName: "bolt"),
                        title: "dashboard.training",
                        value: dashboardViewModel.dailyTrainedTime.description)
                }
            }
        }
        .onAppear {
            dashboardViewModel.getUpdatedValues()
        }
    }
}

#if DEBUG
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
#endif
