//
//  IngredientServicetests.swift
//  RecipleaseTests
//
//  Created by Christophe Expleo on 22/10/2021.
//

import XCTest
@testable import Reciplease

class IngredientServicetests: XCTestCase {
    
    func testWhenAddIngedientMethodThenOneMoreIngredientInIngredients() {
        let testService = IngredientService()
        XCTAssertTrue(testService.ingredients.isEmpty)
        testService.add(ingredient: "Chicken")
        XCTAssertFalse(testService.ingredients.isEmpty)
    }
    
    func testWhenRemoveIngedientMethodThenOneLessIngredientInIngredients() {
        let testService = IngredientService()
        testService.add(ingredient: "Chicken")
        XCTAssertEqual(testService.ingredients.count, 1)
        testService.removeIngredient()
        XCTAssertTrue(testService.ingredients.isEmpty)
    }
}
