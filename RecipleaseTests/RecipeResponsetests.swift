//
//  RecipeResponsetests.swift
//  RecipleaseTests
//
//  Created by Christophe Expleo on 22/10/2021.
//

import XCTest
@testable import Reciplease

class RecipeResponsetests: XCTestCase {
    
    func testDisplayableCaloriesRoundedWithNoDecimalDigits() {
        XCTAssertEqual(Recipe.mock1.displayableCalories,"13 Cal")
    }
    
    func testDisplayableTotalTimeReturnGoodFormat() {
        XCTAssertEqual(Recipe.mock1.displayableTotalTime,"15.78 m")
        XCTAssertEqual(Recipe.mock2.displayableTotalTime,"-- m")
    }
    
    func testDisplayableIngredientsReturnGoodFormat() {
        XCTAssertEqual(Recipe.mock1.displayableIngredients,"Tomato,Cheese")
    }
}
