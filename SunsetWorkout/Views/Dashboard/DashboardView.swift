//
//  DashboardView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 09/09/2022.
//

import HealthKitUI
import SwiftUI

struct DashboardView: View {
    @StateObject var dashboardViewModel = DashboardViewModel()
    @State var displayFeelingSelection: Bool = false
    @State var selectedFeeling: FeelingType = .happy

    var body: some View {
        VStack(alignment: .leading) {
            Spacer(minLength: 20)
            GlassMorphicCard(content: {
                VStack {
                    if let quote = dashboardViewModel.quote {
                        Text(dashboardViewModel.getAuthorSaidLabel(
                            author: quote.author
                        ))
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
                .frame(maxWidth: .infinity)
            }, height: 150)

            Spacer(minLength: 80)

            VStack(spacing: 20) {
                HStack {
                    DashboardCardView(
                        icon: Image(systemName: "bed.double"),
                        title: "dashboard.sleep",
                        value: dashboardViewModel.getSleptLabel())

                    Button {
                        displayFeelingSelection = true
                        if let feeling = dashboardViewModel.feeling {
                            selectedFeeling = feeling.type
                        }
                    } label: {
                        DashboardCardView(
                            icon: Image(systemName: "leaf"),
                            title: "dashboard.feeling",
                            value: (
                                dashboardViewModel.feeling != nil) ?
                            dashboardViewModel.feeling!.type.relatedEmoji : "N/A")
                    }
                    .foregroundColor(Color(.label))
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
            Spacer(minLength: 20)
        }
        .onAppear {
            dashboardViewModel.getUpdatedValues()
        }
        .toastWithError($dashboardViewModel.error)
        .sheet(isPresented: $displayFeelingSelection, onDismiss: {
            self.dashboardViewModel
                .feelingViewModel
                .save(model: Feeling(type: selectedFeeling), with: FeelingEntity.init)
            self.dashboardViewModel.getFeeling()
        }, content: {
            ZStack {
                BackgroundView()
                VStack {
                    Text("feeling.update")
                    Spacer()
                    FeelingSelectionView(selected: $selectedFeeling)
                    Spacer()
                    Button {
                        displayFeelingSelection = false
                    } label: {
                        HStack {
                            Spacer()
                            Text("button.save")
                                .font(.system(.callout))
                            Spacer()
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(Color(.label))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(Capsule().stroke(Color.green))
                    }

                }
                .padding()
            }
        })
    }
}

#if DEBUG
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
#endif
