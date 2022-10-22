//
//  CollectionExtensions.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 22/10/2022.
//

extension Collection {
    func allEqual<T: Equatable>(by key: KeyPath<Element, T>) -> Bool {
        return allSatisfy { first?[keyPath: key] == $0[keyPath: key] }
    }
}
