//
//  RecipeProtocol.swift
//  Reciplease
//
//  Created by Christophe Expleo on 11/10/2021.
//

import Foundation
import UIKit

protocol RecipeProtocol {
    func title() -> String
    func calories() -> String
    func imageUrl() -> URL
    func totalTime() -> String
    func ingredients() -> String
    func ingredientLines() -> [String]
    func isFavorite() -> Bool
}
