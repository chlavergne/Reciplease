//
//  SearchResultsController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import UIKit
import SDWebImage
import CoreData

class SearchResultsController: UIViewController {
    
    // MARK: - Properties
    private var coreDataManager: CoreDataManager?
    static let recipeCellId = "RecipeTableViewCell"
    private var index = 0
    private var isFavorite = false
    private var selectedRecipe: Recipe?
    var showFavorite = true
    var recipes: [Recipe] = []
    var recipesAfterDelete: [Recipe] = []
    
    // MARK: - IBOutlet
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        // Register Cell
        recipesTableView.register(UINib.init(nibName: SearchResultsController.recipeCellId, bundle: nil),
                                  forCellReuseIdentifier: SearchResultsController.recipeCellId)
        recipesTableView.separatorColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if showFavorite == true {
            recipes = coreDataManager!.savedRecipe
        } else {
            recipes = recipesAfterDelete
            
        }
        recipesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? RecipeController, let recipe = selectedRecipe {
            controller.recipe = recipe
            controller.row = index
            controller.isFavorite = isFavorite
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
        cell.favoriteStar.isHidden = true
        let savedRecipe = coreDataManager!.savedRecipe.map({$0.title})
        if savedRecipe.contains(recipeResult.label) {
            cell.favoriteStar.isHidden = false
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRecipe = recipes[indexPath.row]
        let savedRecipe = coreDataManager!.savedRecipe.map({$0.title})
        if savedRecipe.contains(self.selectedRecipe!.title) {
            isFavorite = true
            index = savedRecipe.firstIndex(of: self.selectedRecipe!.title) ?? 0
            recipes = coreDataManager!.savedRecipe
        } else {
            isFavorite = false
        }
        self.performSegue(withIdentifier: "ShowRecipeDetail", sender: nil)
    }
}
