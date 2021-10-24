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
    var url = URL(string:"www.init.com")
    private let session: AlamofireSession
    
    // MARK: - Initializer
    init(session: AlamofireSession = RecipeSession()) {
        self.session = session
    }
    
    // MARK: - Method
    func fetchJSON(callback: @escaping (Result<RecipeResponse, ErrorCase>) -> Void) {
        let urlShort = "https://api.edamam.com/api/recipes/v2"
        let ingredients = IngredientService.shared.ingredients.joined(separator: ",")
        let urlString = "\(urlShort)?q=\(ingredients)&app_id=\(Api().appId)&app_key=\(Api().appKey)&type=public"
        url = URL(string: urlString)
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
            callback(.success(dataDecoded))
        }
    }
    
    func fetchInfiniteScroll(urlNext: URL?, callback: @escaping (Result<RecipeResponse, ErrorCase>) -> Void) {
//        let urlDefault =
        session.request(url: urlNext ?? url!) { (response) in
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
            callback(.success(dataDecoded))
        }
    }
}
