//
//  TypeAlias.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/11/2022.
//

typealias WorkoutRequest = FetchRequest<[SWWorkout], SWWorkoutEntity>
typealias ActivitySummaryRequest = FetchRequest<[SWActivitySummary], SWActivitySummaryEntity>
typealias FeelingRequest = FetchRequest<[Feeling], FeelingEntity>
typealias ThrowableCallback = () throws -> Bool
