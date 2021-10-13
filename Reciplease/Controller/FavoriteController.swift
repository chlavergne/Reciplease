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
    
    static let recipeCellId = "RecipeTableViewCell"
    var favoriteList: [RecipeProtocol] = RecipeFavorite.all
//    private var recipeFavorite: RecipeFavorite?
    
//    init(recipeFavorite: RecipeFavorite) {
//        self.recipeFavorite = recipeFavorite
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register Cell
        favoriteTableView.register(UINib.init(nibName: FavoriteController.recipeCellId, bundle: nil),
                                  forCellReuseIdentifier: FavoriteController.recipeCellId)
        favoriteTableView.separatorColor = UIColor.clear
        favoriteTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteTableView.reloadData()
        self.favoriteList = RecipeFavorite.all
    }
}

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
        
        cell.title.text = recipeResult.title()
        cell.calories.text = recipeResult.calories()
        cell.totalTime.text = recipeResult.totalTime()
        cell.subtitle.text = recipeResult.ingredients()
//        let urlToLoad = recipeResult.imageUrl()
//        cell.recipeImage.sd_setImage(with: urlToLoad,placeholderImage: UIImage(systemName: "generique2"),
//                                     options: .continueInBackground,completed: nil)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let recipeSelected = recipes[indexPath.row].recipe
//        SearchResultsController.recipeToSend = SearchResultsController(recipe: recipeSelected)
//        self.performSegue(withIdentifier: "ShowRecipeDetail", sender: nil)
//    }
}
