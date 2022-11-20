//
//  RealmManager.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/10/2022.
//

import RealmSwift

struct RealmManager {
    let realm: Realm?

    init() {
        realm = try? Realm()
    }

    func save<Model, RealmObject: Object>(model: Model, with reverseTransformer: (Model) -> RealmObject) throws {
        guard let realm else { throw RealmError.noRealm }

        let object = reverseTransformer(model)

        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            throw error
        }
    }

    func saveWithManyRelation<Model, RealmObject: Object, RelationEntity: Object>(
        model: Model,
        with reverseTransformer: (Model) -> RealmObject,
        on: inout RelationEntity,
        withKeyPath: WritableKeyPath<RelationEntity, List<RealmObject>>) throws {
        guard let realm else { throw RealmError.noRealm }

        let object = reverseTransformer(model)

        do {
            try realm.write {
                realm.add(object, update: .modified)
                on[keyPath: withKeyPath].append(object)
            }
        } catch {
            throw error
        }
    }

    func fetch<Model, RealmObject>(with request: FetchRequest<Model, RealmObject>) throws -> Model {
        guard let realm else { throw RealmError.noRealm }

        var results = realm.objects(RealmObject.self)

        if let predicate = request.predicate {
            results = results.filter(predicate)
        }

        if request.sortDescriptors.count > 0 {
            results = results.sorted(by: request.sortDescriptors)
        }

        return request.transformer(results)
    }

    func fetchEntities<Model, RealmObject>(with request: FetchRequest<Model, RealmObject>) throws -> [RealmObject] {
        guard let realm else { throw RealmError.noRealm }

        var results = realm.objects(RealmObject.self)

        if let predicate = request.predicate {
            results = results.filter(predicate)
        }

        if request.sortDescriptors.count > 0 {
            results = results.sorted(by: request.sortDescriptors)
        }

        return Array(results)
    }
}
