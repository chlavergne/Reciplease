//
//  RecipeResponse.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation

struct RecipeResponse: Decodable {
    let count: Int
    let hits:[Recipes]
}

struct Recipes: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let label: String
    let image: String
    let url: String
    let ingredientLines: [String]
    let totalTime: Int
    let calories: Double
    let ingredients: [Ingredient]
}

struct Ingredient: Decodable {
    let food: String
}
