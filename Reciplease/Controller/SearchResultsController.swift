//
//  SearchResultsController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import UIKit

class SearchResultsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchResultsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeService.shared.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = IngredientService.shared.ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.name
        return cell
    }
}

