//
//  WorkoutExerciseSearchView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 17/10/2022.
//

import SwiftUI

struct WorkoutExerciseSearchView: View {
    @StateObject var viewModel = ExerciseSearchViewModel()
    @Binding var search: String
    @Binding var selected: ExerciseSearch?
    @Binding var isSearching: Bool

    var body: some View {
        VStack(alignment: .leading) {
            if search.isEmpty {
                VStack {
                    Spacer()
                    Text(NSLocalizedString("search.empty.search", comment: "Empty search label"))
                    Spacer()
                }
            } else if viewModel.searchEmpty {
                VStack {
                    Button {
                        self.selected = ExerciseSearch(value: search)
                    } label: {
                        SearchItem(value: search)
                    }

                    Spacer()
                }
            } else {
                ScrollView {
                    Button {
                        self.selected = ExerciseSearch(value: search)
                    } label: {
                        SearchItem(value: search)
                    }

                    ForEach(viewModel.results) { exercise in
                        Divider()

                        Button {
                            self.search = exercise.value
                            self.selected = exercise
                        } label: {
                            SearchItem(value: exercise.value)
                        }
                    }
                }
            }

            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView {
                        Text(NSLocalizedString("exercise.search.loading", comment: "Search placeholder"))
                    }
                    Spacer()
                }
            }
        }
        .onChange(of: search, perform: { newValue in
            viewModel.search(for: newValue)
        })
    }
}

#if DEBUG
struct WorkoutExerciseSearchView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutExerciseSearchView(search: .constant("Squats"), selected: .constant(nil), isSearching: .constant(true))
    }
}
#endif

struct SearchItem: View {
    var value: String

    var body: some View {
        HStack {
            Text(value)
                .multilineTextAlignment(.leading)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .font(.title3)
        .foregroundColor(Color(.label))
    }
}
