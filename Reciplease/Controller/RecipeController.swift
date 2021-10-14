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
import CoreData

class RecipeController: UIViewController {
    
    // MARK: - Propertie
    var recipeReceived: RecipeProtocol?
    
//    private var recipe: Recipe?
//
//    init(recipe: RecipeProtocol) {
//        self.recipeReceived = recipe
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var mainRecipeText: UILabel!
    @IBOutlet weak var mainRecipeImage: UIImageView!
    @IBOutlet weak var mainCalories: UILabel!
    @IBOutlet weak var mainTime: UILabel!
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var favoriSelector: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTableView.backgroundView = UIImageView(image: UIImage(named: "ardoise"))
        mainRecipeText.text = recipeReceived!.title()
        mainCalories.text = recipeReceived!.calories()
        mainTime.text = recipeReceived!.totalTime()
        let url = recipeReceived!.imageUrl()
        mainRecipeImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "generique2"), options: .continueInBackground,completed: nil)
        recipeTableView.reloadData()
        
    }
    
    @IBAction func favoriSelector(_ sender: Any) {
        switchFavoriteIcon()
    }
    
    private func switchFavoriteIcon() {
        let selectedImage = UIImage(systemName: "star.fill")
        let unselectedImage = UIImage(systemName: "star")
        if favoriSelector.image(for: .normal) == selectedImage {
            favoriSelector.setImage(unselectedImage, for: .normal)
            removeFromFavorite()
        } else {
            favoriSelector.setImage(selectedImage, for: .normal)
            addToFavorite(recipe: recipeReceived!)
        }
    }
    
    private func addToFavorite(recipe: RecipeProtocol) {
        let savedRecipe = RecipeFavorite(context: AppDelegate.viewContext)
        savedRecipe.savedName = recipe.title()
        savedRecipe.savedCalories = recipe.calories()
        savedRecipe.savedTotalTime = recipe.totalTime()
        savedRecipe.savedIngredients = recipe.ingredients()
        savedRecipe.savedIngredientLines = recipe.ingredientLines()
        savedRecipe.savedUrl = recipe.imageUrl()

        try? AppDelegate.viewContext.save()
    
    }
    
    private func removeFromFavorite() {
       
    }
    
    // MARK: - IBAction
    @IBAction func getDirection(_ sender: Any) {
        if let url = URL(string: "\(recipeReceived!.imageUrl())") {
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
        let totalCell = recipeReceived!.ingredientLines().count
        return totalCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientLineCell", for: indexPath)
        let ingredient = recipeReceived!.ingredientLines()[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}

//extension RecipeController: RecipeProtocol {
//    func title() -> String {
//        mainRecipeText.text = recipeReceived!.title()
//        return mainRecipeText.text!
//    }
//
//    func calories() -> String {
//        let caloriesFormat = String(format: "%.0f", recipeReceived!.calories)
//        mainCalories.text = "\(caloriesFormat) Cal"
//        return mainCalories.text!
//    }
//
//    func imageUrl() -> URL {
//        let url = URL(string:recipeReceived!.imageUrl())
//        return url!
//    }
//
//    func totalTime() -> String {
//        mainTime.text = "\(recipeReceived!.totalTime) m"
//        return mainTime.text!
//    }
//
//    func ingredients() -> String {
//        return ""
//    }
//
//
//}
