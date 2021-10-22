//
//  RecipeService.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation
import Alamofire


enum ErrorCase: Error {
    case noData
    case invalidResponse
    case undecodableData
}

final class RecipeService {
    
    // MARK: - Properties
    static let shared = RecipeService()
    
    private let session: AlamofireSession
    
    // MARK: - Initializer
    init(session: AlamofireSession = RecipeSession()) {
        self.session = session
    }
    
    // MARK: - Method
    func fetchJSON(callback: @escaping (Result<[Recipe], ErrorCase>) -> Void) {
        let urlShort = "https://api.edamam.com/api/recipes/v2"
        let ingredients = IngredientService.shared.ingredients.joined(separator: ",")
        let urlString = "\(urlShort)?q=\(ingredients)&app_id=\(Api().appId)&app_key=\(Api().appKey)&type=public"
        let url = URL(string: urlString)
        session.request(url: url!) { (response) in
            guard let data = response.data else {
                callback(.failure(.noData))
                return
            }
            guard response.response?.statusCode == 200 else {
                callback(.failure(.invalidResponse))
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(RecipeResponse.self, from: data) else {
                callback(.failure(.undecodableData))
                return
            }
            let recipeList = dataDecoded.hits
            let recipes = recipeList.map { recipe in
                recipe.recipe
            }
            callback(.success(recipes))
        }
    }
}
