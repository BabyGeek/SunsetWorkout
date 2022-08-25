//
//  SunsetWorkoutUITestsLaunchTests.swift
//  SunsetWorkoutUITests
//
//  Created by Paul Oggero on 24/08/2022.
//

import XCTest

class SunsetWorkoutUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
        // UI tests must launch the application that they test.
        // Doing this in setup will make sure it happens for each test method.

        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        snapshot("0_Launch")
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
