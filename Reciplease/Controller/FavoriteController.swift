//
//  FavoriteController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 05/10/2021.
//

import Foundation
import UIKit
import SDWebImage
import CoreData

class FavoriteController: UIViewController {
    
    // MARK: - Properties
    static let recipeCellId = "RecipeTableViewCell"
    private var selectedRecipe: Recipe?
    private var favoriteList: [Recipe] = RecipeCoreData.all
    
    // MARK: - IBOutlet
    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register Cell
        favoriteTableView.register(UINib.init(nibName: FavoriteController.recipeCellId, bundle: nil),
                                   forCellReuseIdentifier: FavoriteController.recipeCellId)
        favoriteTableView.separatorColor = UIColor.clear
        favoriteTableView.reloadData()
        
        let request: NSFetchRequest<RecipeCoreData> = RecipeCoreData.fetchRequest()
                guard let recipeToDelete = try? AppDelegate.viewContext.fetch(request) else {
                    return
                }
                for object in recipeToDelete {
                    AppDelegate.viewContext.delete(object)
                    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoriteList = RecipeCoreData.all
        favoriteTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? RecipeController, let recipe = selectedRecipe {
            controller.recipe = recipe
        }
    }
}

// MARK: - Extensions
extension FavoriteController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteController.recipeCellId, for: indexPath) as! RecipeTableViewCell
       let recipeResult = favoriteList[indexPath.row]
        
        cell.title.text = recipeResult.title
        cell.calories.text = recipeResult.displayableCalories
        cell.totalTime.text = recipeResult.displayableTotalTime
        cell.subtitle.text = recipeResult.displayableIngredients
        cell.favoriteStar.isHidden = false
        let urlToLoad = recipeResult.imageUrl
        cell.recipeImage.sd_setImage(with: urlToLoad,placeholderImage: UIImage(systemName: "generique2"),
                                     options: .continueInBackground,completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = favoriteList[indexPath.row]
        self.performSegue(withIdentifier: "ShowFavoriteRecipeDetail", sender: nil)
    }
}
