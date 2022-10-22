//
//  ArrayExtensions.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 22/10/2022.
//

extension Array {
    mutating func replaceOrAppend(_ item: Element, whereFirstIndex predicate: (Element) -> Bool) {
        if let idx = self.firstIndex(where: predicate) {
            self[idx] = item
        } else {
            append(item)
        }
    }
}
