//
//  RecipeResponse.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation

struct RecipeResponse: Decodable {
    let count: Int
    let hits:[ApiRecipe]
}

struct ApiRecipe: Decodable {
    let recipe: Recipe
}

struct Recipe: Decodable {
    let label: String
    let image: String
    let url: String
    let ingredientLines: [String]
    let totalTime: Double
    let calories: Double
    let ingredients: [Ingredient]

    var isFavorite: Bool?
    
    var displayableIngredients: String {
        var joinedList = ""
        let ingredients = ingredients
        let ingredientCount = ingredients.count
        var ingredientList: [String] = []
        
        for i in 0..<ingredientCount {
            ingredientList.append(ingredients[i].food)
            let capitalizedList = ingredientList.map { $0.capitalized }
            joinedList = capitalizedList.joined(separator: ",")
        }
        return joinedList
    }
    
    var title: String {
        return label
    }
    
    var displayableCalories: String {
        return String(format: "%.0f Cal", calories)
    }
    
    var imageUrl: URL {
        let url = URL(string: image)
        return url!
    }
    
    var displayableTotalTime: String {
        let formatedTime: String
        if String(totalTime) == "0" {
            formatedTime = "-- m"
        } else {
            formatedTime = "\(totalTime) m"
        }
        return formatedTime
    }
}

struct Ingredient: Codable {
    let food: String
}

