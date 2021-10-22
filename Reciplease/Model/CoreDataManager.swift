//
//  CoreDataMnager.swift
//  Reciplease
//
//  Created by Christophe Expleo on 12/10/2021.
//

import Foundation
import CoreData

open class CoreDataManager {
    
    let coreDataStack: CoreDataStack
    let managedObjectContext: NSManagedObjectContext
    
    var savedRecipe: [Recipe] {
        let request: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
        var savedRecipe: [RecipeCoreData] = []
        if let recipe = try? managedObjectContext.fetch(request) {
            savedRecipe = recipe
        }
        let recipes = savedRecipe.map { coreDataManager in
            coreDataManager.model
               }
        return recipes
    }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    func insert(recipe: Recipe) {
        let savedRecipe = RecipeCoreData(context: managedObjectContext)
        savedRecipe.title = recipe.label
        savedRecipe.calories = recipe.calories
        savedRecipe.totalTime = recipe.totalTime
        savedRecipe.ingredients = try? JSONEncoder().encode(recipe.ingredients)
        savedRecipe.directionUrl = recipe.url
        savedRecipe.imageUrl = recipe.imageUrl.absoluteString
        savedRecipe.ingredientLines = try? JSONEncoder().encode(recipe.ingredientLines)
        coreDataStack.saveContext()
    }
    
    func remove(recipe: Recipe, row: Int) {
        let itemIDsFetchRequest = NSFetchRequest<NSManagedObjectID>(entityName: "RecipeCoreData")
        itemIDsFetchRequest.resultType = .managedObjectIDResultType
//        do {
        if let ids = try? managedObjectContext.fetch(itemIDsFetchRequest),
           let recipeToDelete = try? managedObjectContext.existingObject(with: ids[row]) {
            managedObjectContext.delete(recipeToDelete)
//        }catch let error as NSError {
//            print("Fetch item failed:\(error), \(error.userInfo)")
        }
        coreDataStack.saveContext()
    }
}
