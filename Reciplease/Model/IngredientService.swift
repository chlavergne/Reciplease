//
//  IngredientService.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation

class IngredientService {
    
    // MARK: - Properties
    var ingredients: [String] = []
    static let shared = IngredientService()
    
    private init() {}
    
    // MARK: - Methods
    func add(ingredient: String) {
        ingredients.append(ingredient)
    }
    
    func removeIngredient() {
        if ingredients.count > 0 {
            ingredients.removeLast()
        } 
    }
}
