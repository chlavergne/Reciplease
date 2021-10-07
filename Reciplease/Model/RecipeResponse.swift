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
//
struct Recipe: Decodable {
    let label: String
//    let image: String
//    let ingredientLines: [String]
//    let totalTime: Int
//    let mealType: [String]
//    let calories: Int
//    let ingredients: [Ingredients]
}

//struct Ingredients: Decodable {
//    let food: String
//}
