//
//  SearchController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 05/10/2021.
//

import UIKit
import Foundation
import CoreData

class SearchController: UIViewController {
    
    // MARK: - Propertie
    var recipesLoaded: [Recipes] = []
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "ardoise"))
        searchBar.delegate = self
        tabBarController?.hidesBottomBarWhenPushed = false
//        delecteCDObject()
        }
    
    // MARK: - IBActions
    @IBAction func dismissKeyboard(_ sender: Any) {
        searchBar.resignFirstResponder()
    }
    
    @IBAction func addIngredient(_ sender: UIButton) {
        guard let ingredientName = searchBar.text else { return }
        IngredientService.shared.add(ingredient: ingredientName)
        tableView.reloadData()
    }
    
    @IBAction func clearCell(_ sender: Any) {
        IngredientService.shared.removeIngredient()
        tableView.reloadData()
    }
    
    @IBAction func loadRecipes(_ sender: Any) {
        loadingIndicator.startAnimating()
    print(IngredientService.shared.ingredients)
        RecipeService.shared.fetchJSON {(error, recipeList) in
            self.loadingIndicator.stopAnimating()
            self.recipesLoaded = recipeList ?? []
            if self.recipesLoaded.count > 0 {
                self.performSegue(withIdentifier: "ShowRecipes", sender: nil)
            } else {
                self.presentAlert(error: error?.localizedDescription ?? "Erreur de chargement")
            }
        }
    }
    
    // MARK: - Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SearchResultsController{
            controller.recipes = self.recipesLoaded
        }
    }
}

//MARK: - Extensions
extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SearchController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let totalCell = IngredientService.shared.ingredients.count
        return totalCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = IngredientService.shared.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient
        return cell
    }
}

extension SearchController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            IngredientService.shared.removeIngredient()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
