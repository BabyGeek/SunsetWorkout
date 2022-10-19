//
//  ExerciseSearchViewModel.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 19/10/2022.
//

import Combine
import Foundation

class ExerciseSearchViewModel: ObservableObject {
    @Published var error: SWError?
    @Published private(set) var results: [ExerciseSearch] = []

    let exerciseSearchLoader = ExerciseSearchLoader(userSession: UserSession())

    func search(for search: String) {
        exerciseSearchLoader.loadResults(matching: search)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error = SWError(error: error)
                case .finished:
                    debugPrint("Publisher is finished")
                }
            } receiveValue: { [weak self] in
                guard let self else { return }
                self.results = $0
            }
            .cancel()

    }
}
