//
//  SearchResultsController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import UIKit
import Foundation

class SearchResultsController: UIViewController {

    let recipeCellId = "RecipeTableViewCell"
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        recipesTableView.reloadData()
        
        // Register Cell
        recipesTableView.register(UINib.init(nibName: recipeCellId, bundle: nil), forCellReuseIdentifier: recipeCellId)
        recipesTableView.separatorColor = UIColor.clear
//        RecipeService.shared.fetchJSON()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        recipesTableView.reloadData()
//    }
}

extension SearchResultsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchController().recipesLoaded.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellId, for: indexPath) as! RecipeTableViewCell
        cell.selectionStyle = .none
//        let ingredient = IngredientService.shared.ingredients[indexPath.row]
        let recipeName = SearchController().recipesLoaded[indexPath.row].recipe.label
        cell.title?.text = recipeName
        return cell
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

