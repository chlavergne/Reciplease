//
//  RecipeService.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation
import Alamofire

class RecipeService {
    static let shared = RecipeService()
    private init() {}
    
    var recipeList: [Recipes] = []
    
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session  = session
    }
    
    func fetchJSON(callback: @escaping (Error?, [Recipes]?) -> Void) {
        let url = urlRequest()
        //        let request = AF.request(url)
        //        request.responseJSON { (data) in
        //              print(data)
        //                }
        //        request.responseDecodable(of: Recipes.self) { (response) in
        //          guard let recipes = response.value else { return }
        //            print(recipes.count)
        //        }
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(error, nil)
                    return
                }
                do {
                    let responseJSON = try JSONDecoder().decode(RecipeResponse.self, from: data)
                    let list = responseJSON
                    self.recipeList = list.hits
                    if self.recipeList.isEmpty {
                        callback(error,nil)} else {
                            callback(nil, self.recipeList)
                        }
                } catch {
                    callback(error, nil)
                    return
                }
            }
        }
        task.resume()
    }
    private func urlRequest() -> URLRequest {
        let urlShort = "https://api.edamam.com/api/recipes/v2"
        let ingredients = IngredientService.shared.ingredients.joined(separator: ",")
        //        let url = "\(urlShort)?q=\(ingredients)&app_id=\(Api().appId)&app_key=\(Api().appKey)&type=public"
        var urlConponents = URLComponents(string: urlShort)!
        urlConponents.queryItems = [URLQueryItem(name: "q", value: ingredients),
                                    URLQueryItem(name: "app_id", value: Api().appId), URLQueryItem(name: "app_key", value: Api().appKey),
                                    URLQueryItem(name: "type", value: "public")]
        var request = URLRequest(url: urlConponents.url!)
        request.httpMethod = "GET"
        return request
    }
}
