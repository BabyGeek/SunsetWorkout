//
//  HistoriesView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 11/11/2022.
//

import SwiftUI

struct HistoriesView: View {
    @StateObject var viewModel: HistoriesViewModel = HistoriesViewModel()

    var body: some View {
        if viewModel.summaries.isEmpty {
            EmptyHistoryView()
        } else {
            ScrollView {
                ForEach(viewModel.summaries) { summary in
                    NavigationLink {
                        HistoryView(summary: summary)
                    } label: {
                        HistoryCardView(summary: summary)
                            .foregroundColor(Color(.label))
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}

struct HistoriesView_Previews: PreviewProvider {
    static var previews: some View {
        HistoriesView()
    }
}
