//
//  AppDelegate.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 27/11/2022.
//

import RealmSwift
import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    @AppStorage("hasLoadedDailyQuote", store: UserDefaults(suiteName: "defaults.com.poggero.SunsetWorkout")) var hasLoadedDailyQuote: Bool = false
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let config = Realm.Configuration(
            schemaVersion: K.Database.schemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < K.Database.schemaVersion) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        Realm.Configuration.defaultConfiguration = config
        hasLoadedDailyQuote = false

        return true
    }
}
