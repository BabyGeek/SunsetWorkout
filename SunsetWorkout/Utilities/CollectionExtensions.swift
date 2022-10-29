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
    
    func sorted<Value: Comparable>(by keyPath: KeyPath<Self.Element, Value>, order: Order = .asc) -> [Self.Element]
    {
        switch order {
        case .asc:
            return self.sorted(by: { $0[keyPath: keyPath]  <  $1[keyPath: keyPath] })
        case .desc:
            return self.sorted(by: { $0[keyPath: keyPath]  >  $1[keyPath: keyPath] })
        }
    }
}
