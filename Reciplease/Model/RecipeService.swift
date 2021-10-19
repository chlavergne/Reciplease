//
//  RecipeService.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation
import Alamofire


enum ErrorCases: Error {
    case noData
    case invalidResponse
    case undecodableData
}

class RecipeService {
    
    // MARK: - Properties
    static let shared = RecipeService()
    
    private init() {}
    
    // MARK: - Method
    func fetchJSON(callback: @escaping (Result<[Recipe], ErrorCases>) -> Void) {
        let urlShort = "https://api.edamam.com/api/recipes/v2"
        let ingredients = IngredientService.shared.ingredients.joined(separator: ",")
        let url = "\(urlShort)?q=\(ingredients)&app_id=\(Api().appId)&app_key=\(Api().appKey)&type=public"
        let request = AF.request(url)
        request.responseDecodable(of: RecipeResponse.self) { (response) in
            guard response.data != nil else {
                callback(.failure(.noData))
                return
            }
            guard response.response?.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let recipeList = response.value?.hits else {
                callback(.failure(.undecodableData))
                return
            }
            let recipes = recipeList.map { recipe in
                recipe.recipe
            }
            callback(.success(recipes))
        }
    }
}
