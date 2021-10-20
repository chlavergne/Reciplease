//
//  SearchController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 05/10/2021.
//

import UIKit
import CoreData

class SearchController: UIViewController {
    
    // MARK: - Propertie
    private var recipesLoaded: [Recipe] = []
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "ardoise"))
        searchBar.delegate = self
        tabBarController?.hidesBottomBarWhenPushed = false
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
        RecipeService.shared.fetchJSON (callback: { result in
            switch result {
            case .success(let recipes):
                self.loadingIndicator.stopAnimating()
                self.recipesLoaded = recipes
                self.performSegue(withIdentifier: "ShowRecipes", sender: nil)
            case .failure(let error):
                switch error {
                case .noData:
                    self.presentAlert(error: "No data received from the distant server")
                case .invalidResponse:
                    self.presentAlert(error: "Statut code error")
                case.undecodableData:
                    self.presentAlert(error: "Failure while trying to decode response")
                }
            }
        })
    }
    
    // MARK: - Method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SearchResultsController{
            controller.recipes = self.recipesLoaded
            controller.recipesAfterDelete = self.recipesLoaded
            controller.showFavorite = false
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
            IngredientService.shared.ingredients.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
