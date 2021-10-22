//
//  Recipe+Mock.swift
//  RecipleaseTests
//
//  Created by Christophe Expleo on 22/10/2021.
//

import Foundation
@testable import Reciplease

// MARK: - Extensions RecipeResponse struct for Tests access
extension Recipe {
    static var mock1: Recipe = {
        return Recipe(label: "test value 1", image: "", url: "", ingredientLines: [], totalTime: 15.78, calories: 12.999, ingredients: [Ingredient(food: "Tomato"), Ingredient(food: "Cheese")], isFavorite: false)
    }()

    static var mock2: Recipe = {
        return Recipe(label: "test value 2", image: "", url: "", ingredientLines: [], totalTime: 0.0, calories: 0, ingredients: [], isFavorite: false)
    }()
    
    static var mockIngredients: [Ingredient] = {
        return [Ingredient(food: "Tomato"), Ingredient(food: "Cheese")]
    }()
}
