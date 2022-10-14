//
//  FetchRequest.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/10/2022.
//

import Foundation
import RealmSwift

struct FetchRequest<Model, RealmObject: Object> {
    let predicate: NSPredicate?
    let sortDescriptors: [RealmSwift.SortDescriptor]
    let transformer: (Results<RealmObject>) -> Model
}

extension RealmSwift.SortDescriptor {
    static let name = SortDescriptor(keyPath: "name", ascending: true)

    static let type = SortDescriptor(keyPath: "rawType", ascending: true)

    static let createdAtASC = SortDescriptor(keyPath: "created_at", ascending: true)
    static let createdAtDESC = SortDescriptor(keyPath: "created_at", ascending: false)
}

extension SWWorkout {
    static let allByNameASC = FetchRequest<[SWWorkout], SWWorkoutModel>(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.name],
        transformer: { $0.map(SWWorkout.init) }
    )

    static let allByDateASC = FetchRequest<[SWWorkout], SWWorkoutModel>(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.createdAtASC],
        transformer: { $0.map(SWWorkout.init) }
    )

    static let allByDateDESC = FetchRequest<[SWWorkout], SWWorkoutModel>(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.createdAtDESC],
        transformer: { $0.map(SWWorkout.init) }
    )
}

extension Feeling {
    static let allByTypeASC = FetchRequest<[Feeling], FeelingModel>(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.type],
        transformer: { $0.map(Feeling.init) }
    )

    static let allByDateASC = FetchRequest<[Feeling], FeelingModel>(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.createdAtASC],
        transformer: { $0.map(Feeling.init) }
    )

    static let allByDateDESC = FetchRequest<[Feeling], FeelingModel>(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.createdAtDESC],
        transformer: { $0.map(Feeling.init) }
    )
}
