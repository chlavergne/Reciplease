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
        
        // Register Cell
        recipesTableView.register(UINib.init(nibName: recipeCellId, bundle: nil), forCellReuseIdentifier: recipeCellId)
//        recipesTableView.rowHeight = UITableView.automaticDimension
        recipesTableView.separatorColor = UIColor.clear
        recipesTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        recipesTableView.reloadData()
    }
}

extension SearchResultsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IngredientService.shared.ingredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recipeCellId, for: indexPath) as! RecipeTableViewCell
        cell.selectionStyle = .none
        let ingredient = IngredientService.shared.ingredients[indexPath.row]
        cell.subtitle?.text = ingredient.name
        return cell
    }
}
