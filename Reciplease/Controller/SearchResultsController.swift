//
//  SearchResultsController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import UIKit
import Foundation
import SDWebImage
import CoreData
class SearchResultsController: UIViewController {
    
    // MARK: - Properties
    
    static let recipeCellId = "RecipeTableViewCell"
    var showFavorite = true
    var recipes: [Recipe] = []
    private var selectedRecipe: Recipe?
    
    
    // MARK: - IBOutlet
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Cell
        recipesTableView.register(UINib.init(nibName: SearchResultsController.recipeCellId, bundle: nil),
                                  forCellReuseIdentifier: SearchResultsController.recipeCellId)
        recipesTableView.separatorColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if showFavorite == true {
            recipes = RecipeCoreData.all
        }
        recipesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? RecipeController, let recipe = selectedRecipe {
            controller.recipe = recipe
        }
    }
}

// MARK: - Extensions
extension SearchResultsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsController.recipeCellId, for: indexPath) as! RecipeTableViewCell
        let recipeResult = recipes[indexPath.row]
        
        cell.title.text = recipeResult.label
        cell.calories.text = recipeResult.displayableCalories
        cell.totalTime.text = recipeResult.displayableTotalTime
        cell.subtitle.text = recipeResult.displayableIngredients
        let urlToLoad = recipeResult.imageUrl
        cell.recipeImage.sd_setImage(with: urlToLoad,placeholderImage: UIImage(systemName: "generique2"),
                                     options: .continueInBackground,completed: nil)
        cell.favoriteStar.isHidden = !(recipeResult.isFavorite ?? false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRecipe = recipes[indexPath.row]
        self.performSegue(withIdentifier: "ShowRecipeDetail", sender: nil)
    }
}

extension UIViewController {
    func presentAlert(error: String) {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
