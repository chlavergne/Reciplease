//
//  IngredientService.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation

final class IngredientService {
    
    // MARK: - Properties
    var ingredients: [String] = []
    static let shared = IngredientService()
    
    init() {}

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
