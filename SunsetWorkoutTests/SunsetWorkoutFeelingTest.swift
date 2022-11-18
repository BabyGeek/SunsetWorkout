//
//  SunsetWorkoutFeelingTest.swift
//  SunsetWorkoutTests
//
//  Created by Paul Oggero on 14/11/2022.
//

import XCTest
import RealmSwift
@testable import SunsetWorkout

final class SunsetWorkoutFeelingTest: XCTestCase {
    var viewModel: FeelingViewModel!

    override func setUp() {
        super.setUp()
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "SunsetWorkoutTestsRealmFeelings"
        viewModel = FeelingViewModel()
    }

    func testNewFeelingViewModel() throws {
        XCTAssertNil(viewModel.error)
        XCTAssertNil(viewModel.feelings)
    }

    func testAddFeeling() throws {
        let feeling = Feeling(type: .happy)
        viewModel.save(model: feeling, with: FeelingEntity.init)

        XCTAssertNil(viewModel.error)
    }

    func testFetchFeeling() throws {
        let feeling = Feeling(type: .happy)
        viewModel.save(model: feeling, with: FeelingEntity.init)

        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.getLastFeeling()!.id, feeling.id)
        XCTAssertNotNil(viewModel.feelings)
    }

    func testUpdateFeeling() throws {
        let firstFeeling = Feeling(type: .happy)
        viewModel.save(model: firstFeeling, with: FeelingEntity.init)

        let updatedFeeling = Feeling(type: .excited)
        viewModel.save(model: updatedFeeling, with: FeelingEntity.init)

        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.getLastFeeling()!.id, updatedFeeling.id)
        XCTAssertNotNil(viewModel.feelings)
    }

    func testFeelingTypes() throws {
        for feeling in FeelingType.allCases {
            try testFeeling(feeling)
        }
    }

    func testFeeling(_ type: FeelingType) throws {
        let feeling = Feeling(type: type)
        XCTAssertEqual(feeling.type.rawValue, type.rawValue)
        XCTAssertEqual(feeling.type.shortName, type.shortName)
        XCTAssertEqual(feeling.type.relatedEmoji, type.relatedEmoji)
        XCTAssertEqual(feeling.type.relatedDescription, type.relatedDescription)
    }

}
