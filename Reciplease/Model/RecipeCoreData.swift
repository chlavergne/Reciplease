//
//  RecipeCoreData.swift
//  Reciplease
//
//  Created by Christophe Expleo on 21/10/2021.
//

import CoreData

class RecipeCoreData: NSManagedObject {
    var model: Recipe {
        let ingredient = try! JSONDecoder().decode([Ingredient].self, from: self.ingredients!)
        let ingredientLines = try! JSONDecoder().decode([String].self, from: self.ingredientLines!)
        var recipe = Recipe(label: title!, image: imageUrl!, url: directionUrl!, ingredientLines: ingredientLines,
                            totalTime: totalTime, calories: calories, ingredients: ingredient)
        recipe.isFavorite = true
        return recipe
    }
}
