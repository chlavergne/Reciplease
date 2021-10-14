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
    var isFavorite: Bool?

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
        isFavorite = recipeReceived!.isFavorite()
        setFavorite()
        print(isFavorite!)
        mainRecipeImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "generique2"), options: .continueInBackground,completed: nil)
        recipeTableView.reloadData()
        
    }
    
    @IBAction func favoriSelector(_ sender: Any) {
        switchFavoriteIcon()
    }
    
    private func switchFavoriteIcon() {
        if isFavorite == false {
            isFavorite = true
            setFavorite()
            addToFavorite(recipe: recipeReceived!)
           
        } else {
            isFavorite = false
            setFavorite()
            removeFromFavorite()
          
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
        savedRecipe.savedIsFavorite = isFavorite!
        try? AppDelegate.viewContext.save()
        
    }
    
    private func removeFromFavorite() {
        AppDelegate.viewContext.delete(recipeReceived! as! NSManagedObject)
        try? AppDelegate.viewContext.save()
    }
    
    private func setFavorite() {
        let selectedImage = UIImage(systemName: "star.fill")
        let unselectedImage = UIImage(systemName: "star")
        if isFavorite == true {
            favoriSelector.setImage(selectedImage, for: .normal)
        } else {
            favoriSelector.setImage(unselectedImage, for: .normal)
        }
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
