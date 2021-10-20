//
//  RecipeSession.swift
//  Reciplease
//
//  Created by Christophe Expleo on 20/10/2021.
//

import Foundation

import Alamofire

protocol AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void)
}
final class RecipeSession: AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { dataResponse in
            callback(dataResponse)
        }
    }
}
