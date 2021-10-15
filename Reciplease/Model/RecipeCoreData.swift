//
//  RecipeFavorite.swift
//  Reciplease
//
//  Created by Christophe Expleo on 12/10/2021.
//

import Foundation
import CoreData

class RecipeCoreData: NSManagedObject {
    private static let context = AppDelegate.viewContext
    
    static var all: [Recipe] {
        let request: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
        guard let recipeFavourites = try? AppDelegate.viewContext.fetch(request) else { return [] }
        let recipes = recipeFavourites.map { recipeCoreData in
            recipeCoreData.model
        }
        return recipes
    }
    
    static func insert(recipe: Recipe) {
        let savedRecipe = RecipeCoreData(context: context)
        savedRecipe.title = recipe.label
        savedRecipe.calories = recipe.calories
        savedRecipe.totalTime = recipe.totalTime
        savedRecipe.ingredients = try? JSONEncoder().encode(recipe.ingredients)
        savedRecipe.directionUrl = recipe.url
        savedRecipe.imageUrl = recipe.imageUrl.absoluteString
        savedRecipe.ingredientLines = try? JSONEncoder().encode(recipe.ingredientLines)
        try? context.save()
    }
    
    static func remove(recipe: Recipe) {
     // fetch l'ID from coredata   let recipeCoreData =
        // context.delete(recipeCoreData)
    }
    var model: Recipe {
        let ingredient = try! JSONDecoder().decode([Ingredient].self, from: self.ingredients!)
        let ingredientLines = try! JSONDecoder().decode([String].self, from: self.ingredientLines!)
        var recipe = Recipe(label: title!, image: imageUrl!, url: directionUrl!, ingredientLines: ingredientLines, totalTime: totalTime, calories: calories, ingredients: ingredient)
        recipe.isFavorite = true
        return recipe
    }
}
