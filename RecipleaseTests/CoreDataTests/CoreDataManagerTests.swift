//
//  CoreDataManagerTests.swift
//  RecipleaseTests
//
//  Created by Christophe Expleo on 21/10/2021.
//

import XCTest
@testable import Reciplease


class CoreDataManagerTests: XCTestCase {

    // MARK: - Properties
    
    var coreDataStack: MockCoreDataStack!
    var coreDataManager: CoreDataManager!
    
    // MARK: - Tests Life Cycle
    
    override func setUp() {
        super.setUp()
        coreDataStack = MockCoreDataStack()
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        coreDataStack = nil
    }
    
    // MARK: - Tests
    
//    func testAddRecipeToFavoritesMethods_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
//        let recipeTest: Recipe
//        coreDataManager.insert(recipe: recipeTest)
//        XCTAssertTrue(RecipeCoreData().all.isEmpty)
//        XCTAssertTrue(RecipeCoreData.count == 1)
//        XCTAssertTrue(coreDataManager.RecipeCoreData[0].title! == "Chicken Vesuvio")
//    }
}
