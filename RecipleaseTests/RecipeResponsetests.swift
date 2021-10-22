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
        let recipeTest = Recipe(testValue: "Test to add a recipe")
        XCTAssertEqual(recipeTest.displayableCalories,"13 Cal")
    }
    
    func testDisplayableTotalTimeReturnGoodFormat() {
        var recipeTest = Recipe(testValue: "Test to add a recipe")
        XCTAssertEqual(recipeTest.displayableTotalTime,"15.78 m")
        recipeTest.totalTime = 0.0
        XCTAssertEqual(recipeTest.displayableTotalTime,"-- m")
    }
    
    func testDisplayableIngredientsReturnGoodFormat() {
        var recipeTest = Recipe(testValue: "Test to add a recipe")
        let ingredient1 = Ingredient(testValue: "cheese")
        let ingredient2 = Ingredient(testValue: "tomato")
        recipeTest.ingredients = [ingredient1, ingredient2]
        XCTAssertEqual(recipeTest.displayableIngredients,"Cheese,Tomato")
    }
}
