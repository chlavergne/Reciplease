//
//  RecipeService.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import UIKit
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
    var url: URL?

    // MARK: - Initializer
    init(session: AlamofireSession = RecipeSession()) {
        self.session = session
    }

    // MARK: - Methods
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
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5, execute: {
            self.session.request(url: urlNext ?? self.url!) { (response) in
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
        })
    }
}
