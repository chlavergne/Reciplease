//
//  RecipeController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//


import UIKit
import SDWebImage
import SafariServices
import CoreData

class RecipeController: UIViewController {
    
    // MARK: - Properties
    private var coreDataManager: CoreDataManager?
    var recipe: Recipe!
    var isFavorite = false
    var row = 0
    
    // MARK: - IBOutlets
    @IBOutlet weak var mainRecipeText: UILabel!
    @IBOutlet weak var mainRecipeImage: UIImageView!
    @IBOutlet weak var mainCalories: UILabel!
    @IBOutlet weak var mainTime: UILabel!
    @IBOutlet weak var recipeTableView: UITableView!
    @IBOutlet weak var favoriSelector: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        recipeTableView.backgroundView = UIImageView(image: UIImage(named: "ardoise"))
        mainRecipeText.text = recipe.title
        mainCalories.text = recipe.displayableCalories
        mainTime.text = recipe!.displayableTotalTime
        let url = recipe.imageUrl
        setFavorite()
        mainRecipeImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "generique2"),
                                    options: .continueInBackground,completed: nil)
        recipeTableView.reloadData()
    }
    
    @IBAction func favoriSelector(_ sender: Any) {
        switchFavoriteIcon()
    }
    
    private func switchFavoriteIcon() {
        if isFavorite == false {
            isFavorite = true
            setFavorite()
            addToFavorite(recipe: recipe!)
        } else {
            isFavorite = false
            setFavorite()
            removeFromFavorite(recipe: recipe!)
        }
    }
    
    private func addToFavorite(recipe: Recipe) {
        coreDataManager!.insert(recipe: recipe)
    }
    
    private func removeFromFavorite(recipe: Recipe) {
        coreDataManager!.remove(recipe: recipe, row: row)
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
        if let url = URL(string: recipe.url) {
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
        let totalCell = recipe.ingredientLines.count
        return totalCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientLineCell", for: indexPath)
        let ingredient = recipe.ingredientLines[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}
