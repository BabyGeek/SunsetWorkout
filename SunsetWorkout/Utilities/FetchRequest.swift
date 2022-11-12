//
//  FetchRequest.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/10/2022.
//

import Foundation
import RealmSwift

struct FetchRequest<Model, RealmObject: Object> {
    var predicate: NSPredicate?
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
    static func find(_ id: String, with request: WorkoutRequest?) -> WorkoutRequest {
        let predicate = NSPredicate(format: "_id == %@", id)
        var request = request ?? self.allByDateASC
        request.predicate = predicate

        return request
    }

    static let allByNameASC = WorkoutRequest(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.name],
        transformer: { $0.map(SWWorkout.init) }
    )

    static let allByDateASC = WorkoutRequest(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.createdAtASC],
        transformer: { $0.map(SWWorkout.init) }
    )

    static let allByDateDESC = WorkoutRequest(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.createdAtDESC],
        transformer: { $0.map(SWWorkout.init) }
    )
}

extension SWActivitySummary {
    static let allByDateASC = ActivitySummaryRequest(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.createdAtASC],
        transformer: { $0.map(SWActivitySummary.init) }
    )
    
    static let allByDateDESC = ActivitySummaryRequest(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.createdAtDESC],
        transformer: { $0.map(SWActivitySummary.init) }
    )
}

extension Feeling {
    static let allByTypeASC = FeelingRequest(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.type],
        transformer: { $0.map(Feeling.init) }
    )

    static let allByDateASC = FeelingRequest(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.createdAtASC],
        transformer: { $0.map(Feeling.init) }
    )

    static let allByDateDESC = FeelingRequest(
        predicate: nil,
        sortDescriptors: [RealmSwift.SortDescriptor.createdAtDESC],
        transformer: { $0.map(Feeling.init) }
    )
}
