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
    
    // MARK: - IBOutlet
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Cell
        recipesTableView.register(UINib.init(nibName: SearchResultsController.recipeCellId, bundle: nil), forCellReuseIdentifier: SearchResultsController.recipeCellId)
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
        cell.selectionStyle = .none
        let recipeName = recipes[indexPath.row].recipe
        cell.title.text = recipeName.label
        let caloriesFormat = String(format: "%.0f", recipeName.calories)
        cell.calories.text = "\(caloriesFormat) Cal"
        if String(recipeName.totalTime) == "0" {
            cell.totalTime.text = "-- m"} else {
                cell.totalTime.text = "\(recipeName.totalTime) m"
            }
        let url = URL(string:recipeName.image)
        cell.recipeImage.sd_setImage(with: url,placeholderImage: UIImage(systemName: "generique2"), options: .continueInBackground,completed: nil)
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

