//
//  RealmManager.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 06/10/2022.
//

import RealmSwift

class RealmManager {
    let realm: Realm?

    init() {
        realm = try? Realm()
    }

    func saveObject<C: Object>(_ object: C) throws {
        guard let realm else { throw RealmError.noRealm }

        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            throw error
        }
    }
    
    func getObjects<Element: RealmFetchable>(_ type: Element.Type) throws -> Results<Element> {
        guard let realm else { throw RealmError.noRealm }
        
        return realm.objects(type)
    }
}
