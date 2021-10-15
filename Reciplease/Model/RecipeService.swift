//
//  RecipeService.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation
import Alamofire

class RecipeService {
    
    // MARK: - Properties
    static let shared = RecipeService()
    
    private init() {}
    
    // MARK: - Method
    func fetchJSON(callback: @escaping (Error?, [Recipe]?) -> Void) {
        let urlShort = "https://api.edamam.com/api/recipes/v2"
        let ingredients = IngredientService.shared.ingredients.joined(separator: ",")
        let url = "\(urlShort)?q=\(ingredients)&app_id=\(Api().appId)&app_key=\(Api().appKey)&type=public"
        let request = AF.request(url)
        request.responseDecodable(of: RecipeResponse.self) { (response) in
            guard let recipeList = response.value?.hits else { return }
            let recipes = recipeList.map { recipe in
                recipe.recipe
            }
            callback(nil,recipes)
        }
    }
}
