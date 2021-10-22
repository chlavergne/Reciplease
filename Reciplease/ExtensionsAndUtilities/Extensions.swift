//
//  Extensions.swift
//  Reciplease
//
//  Created by Christophe Expleo on 19/10/2021.
//

import UIKit

//MARK: - Extensions

extension UIViewController {
    func presentAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extensions UITableView for placeHolder Text when empty
extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        label.font = UIFont(name:"Noteworthy Light", size: 20.0)
        label.textAlignment = .center
        // styling
        label.sizeToFit()

        self.isScrollEnabled = false
        self.backgroundView = label
        self.separatorStyle = .none
    }
}
extension UITableView {
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
// MARK: - Extensions RecipeResponse struct for Tests access
extension Recipe {
    init(testValue: String) {
        label = testValue
        image = ""
        url = "www.test.com"
        ingredientLines = []
        totalTime = 15.78
        calories = 12.99999
        ingredients =  []
        isFavorite =  false
    }
}

extension Ingredient {
    init(testValue: String) {
        food = testValue
    }
}
