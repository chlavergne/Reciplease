//
//  RecipeResponse.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation

struct RecipeResponse: Codable {
    let recipe: Recipe
}

struct Recipe: Codable {
    let label: String
    let image: String
    let ingredientLines: [String]
    let totalTime: Int
    let mealType: [String]
    let calories: Int
    let ingredients: [Ingredients]
}

struct Ingredients: Codable {
    let food: String
}
