//
//  RecipeFavorite.swift
//  Reciplease
//
//  Created by Christophe Expleo on 12/10/2021.
//

import Foundation
import CoreData

class RecipeFavorite: NSManagedObject {
    static var all: [RecipeFavorite] {
        let request: NSFetchRequest<RecipeFavorite> = RecipeFavorite.fetchRequest()
        guard let recipeFavourites = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return recipeFavourites
    }
}

extension RecipeFavorite: RecipeProtocol {
    func urlDirections() -> String {
        return ""
    }
    
    func title() -> String {
        
        return savedName!
    }
    
    func calories() -> String {
        return savedCalories!
    }
    
    func imageUrl() -> URL{
        return savedUrl!
    }
    
    func totalTime() -> String {
        return savedTotalTime!
    }
    
    func ingredients() -> String {
        return savedIngredients!
    }
    
    func ingredientLines() -> [String] {
        return savedIngredientLines!
    }
    
    func isFavorite() -> Bool {
        return savedIsFavorite
    }
    
}
