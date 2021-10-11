//
//  SearchResultsController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import UIKit
import Foundation
import SDWebImage

class SearchResultsController: UIViewController {
    
    
    // MARK: - Properties
    static var recipeToSend: Recipes?
    
    static let recipeCellId = "RecipeTableViewCell"
    var recipes: [Recipes] = []
    var recipe: Recipe?
    
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
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
        recipesTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? RecipeController{
            controller.recipeReceived = SearchResultsController.recipeToSend
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
        let recipeName = recipes[indexPath.row].recipe
        
        cell.title.text = SearchResultsController(recipe: recipeName).title()
        cell.calories.text = SearchResultsController(recipe: recipeName).calories()
        cell.totalTime.text = SearchResultsController(recipe: recipeName).totalTime()
        cell.subtitle.text = SearchResultsController(recipe: recipeName).ingredients()
        let urlToLoad = SearchResultsController(recipe: recipeName).imageUrl()
        cell.recipeImage.sd_setImage(with: urlToLoad,placeholderImage: UIImage(systemName: "generique2"),
                                     options: .continueInBackground,completed: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeSelected = recipes[indexPath.row]
        SearchResultsController.recipeToSend = recipeSelected
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

extension SearchResultsController: RecipeProtocol {
    
    func ingredients() -> String {
        var joinedList = ""
        let ingredients = recipe!.ingredients
        let ingredientCount = ingredients.count
        var ingredientList: [String] = []
        
        for i in 0..<ingredientCount {
            ingredientList.append(ingredients[i].food)
            let capitalizedList = ingredientList.map { $0.capitalized }
            joinedList = capitalizedList.joined(separator: ",")
        }
        return joinedList
    }
    
    func title() -> String {
        return recipe!.label
    }
    
    func calories() -> String {
        let caloriesFormat = String(format: "%.0f", recipe!.calories)
        return "\(caloriesFormat) Cal"
    }
    
    func imageUrl() -> URL {
        let url = URL(string:recipe!.image)
        return url!
    }
    
    func totalTime() -> String {
        let formatedTime: String
        if String(recipe!.totalTime) == "0" {
            formatedTime = "-- m"
        } else {
            formatedTime = "\(recipe!.totalTime) m"
        }
        return formatedTime
    }
}
