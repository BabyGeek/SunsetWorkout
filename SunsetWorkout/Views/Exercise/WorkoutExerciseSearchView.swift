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
        ZStack {
            BackgroundView()
            VStack(alignment: .leading) {
                    HStack {
                        TextField("exercise.search.field.placeholder", text: $search)
                            .padding(6)
                            .foregroundColor(Color(.label))
                            .background(Color(.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray), lineWidth: 2)
                            )
                            .cornerRadius(12)
                            .overlay(
                                Button {
                                    search = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(Color(.label))
                                }
                                    .padding(.trailing)
                                    .conditional(search.isEmpty, { view in
                                    view
                                        .hidden()
                                }), alignment: .trailing
                            )
                            .padding()

                    }
                    .padding(6)
                    .overlay(
                        Button {
                            isSearching = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color(.label))
                                .frame(width: 20, height: 20)
                        }, alignment: .topTrailing)
                    .padding(6)

                Spacer()

                if search.isEmpty {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("exercise.search.empty")
                            Spacer()
                        }
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

                    if viewModel.isLoading {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                ProgressView {
                                    Text("exercise.search.loading")
                                }
                                Spacer()
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
                }
            }
            .onChange(of: search, perform: { newValue in
                viewModel.search(for: newValue)
            })
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading:
                                    Button(action: {
                                        self.isSearching = false
                                    }, label: {
                                        Image(systemName: "chevron.left")
                                            .resizable()
                                            .scaledToFit()
                                    })
                                    .padding(.horizontal))
        }
        .toastWithError($viewModel.error)
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
