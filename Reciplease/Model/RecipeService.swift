//
//  RecipeService.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation

class RecipeService {
    static let shared = RecipeService()
    private init() {}

    private(set) var recipes: [Recipe] = []
}
