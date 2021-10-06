//
//  IngredientService.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation

class IngredientService {
    static let shared = IngredientService()
    private init() {}

    private(set) var ingredients: [Ingredient] = []

    func add(ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
}
