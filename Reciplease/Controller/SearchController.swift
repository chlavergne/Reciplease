//
//  SearchController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 05/10/2021.
//

import UIKit
import Foundation

class SearchController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        searchBar.resignFirstResponder()
    }
    
    @IBAction func addIngredient(_ sender: UIButton) {
        guard let name = searchBar.text else {
            return
        }
        let ingredient = Ingredient(name: name)
        IngredientService.shared.add(ingredient: ingredient)
        tableView.reloadData()
    }
    
    @IBAction func clearCell(_ sender: Any) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "ardoise"))
        searchBar.delegate = self
    }
}

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
        cell.textLabel?.text = ingredient.name
        return cell
    }
}

extension SearchController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            IngredientService.shared.removeIngredient(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
