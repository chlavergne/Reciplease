//
//  RecipeController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation
import UIKit
import SDWebImage
import SafariServices

class RecipeController: UIViewController {
    
    // MARK: - Propertie
    var recipeReceived: Recipes!
    
    // MARK: - IBOutlets
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var mainRecipeImage: UIImageView!
    @IBOutlet weak var mainCalories: UILabel!
    @IBOutlet weak var mainTime: UILabel!
    @IBOutlet weak var recipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.backgroundView = UIImageView(image: UIImage(named: "ardoise"))
        recipeName.text = recipeReceived?.recipe.label
        let url = URL(string:recipeReceived!.recipe.image)
        mainRecipeImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "generique2"), options: .continueInBackground,completed: nil)
        let caloriesFormat = String(format: "%.0f", recipeReceived.recipe.calories)
        mainCalories.text = "\(caloriesFormat) Cal"
        mainTime.text = "\(recipeReceived.recipe.totalTime) m"
        recipeTableView.reloadData()
        
    }
    
    // MARK: - IBAction
    @IBAction func getDirection(_ sender: Any) {
        if let url = URL(string: "\(recipeReceived.recipe.url)") {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
}

// MARK: - Extension
extension RecipeController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalCell = recipeReceived.recipe.ingredientLines.count
        return totalCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientLineCell", for: indexPath)
        let ingredient = recipeReceived.recipe.ingredientLines[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}
