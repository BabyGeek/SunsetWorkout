//
//  HKQueriable.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/10/2022.
//

import HealthKit

protocol HKQueriable {
    associatedtype QueryType: HKQuery
    var query: QueryType? { get set }

    func executeQuery()
}
