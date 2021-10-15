//
//  TemporyFileDeleteCDObject.swift
//  Reciplease
//
//  Created by Christophe Expleo on 15/10/2021.
//

import Foundation
import CoreData

func delecteCDObject() {
    let request: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
                    guard let recipeToDelete = try? AppDelegate.viewContext.fetch(request) else {
                        return
                    }
                    for object in recipeToDelete {
                        AppDelegate.viewContext.delete(object)
                        }
            try? AppDelegate.viewContext.save()
}
