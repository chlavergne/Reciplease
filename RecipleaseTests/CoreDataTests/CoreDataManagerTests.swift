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
    
    func testInsertMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlySaved() {
        let recipeTest = Recipe(testValue: "Test to add a recipe")
        XCTAssertTrue(coreDataManager.savedRecipe.isEmpty)
        coreDataManager.insert(recipe: recipeTest)
        print(coreDataManager.savedRecipe)
//        XCTAssertTrue(coreDataManager.savedRecipe.isEmpty)
        XCTAssertTrue(coreDataManager.savedRecipe.count == 1)
        XCTAssertTrue(coreDataManager.savedRecipe[0].title == "Test to add a recipe")
    }
    
    func testDeleteAllTasksMethod_WhenAnEntityIsCreated_ThenShouldBeCorrectlyDeleted() {
        let recipeTest = Recipe(testValue: "Test to add a recipe")
        coreDataManager.insert(recipe: recipeTest)
        coreDataManager.remove(recipe: recipeTest, row: 0)
        XCTAssertTrue(coreDataManager.savedRecipe.isEmpty)
    }
}
