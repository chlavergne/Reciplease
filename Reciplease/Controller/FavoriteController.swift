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
    
    // MARK: - Properties
    static let recipeCellId = "RecipeTableViewCell"
    static var recipeToSend: RecipeProtocol?
    private var favoriteList: [RecipeProtocol] = RecipeFavorite.all
    
    // MARK: - IBOutlet
    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register Cell
        favoriteTableView.register(UINib.init(nibName: FavoriteController.recipeCellId, bundle: nil),
                                   forCellReuseIdentifier: FavoriteController.recipeCellId)
        favoriteTableView.separatorColor = UIColor.clear
        favoriteTableView.reloadData()
        
        let request: NSFetchRequest<RecipeFavorite> = RecipeFavorite.fetchRequest()
                guard let recipeToDelete = try? AppDelegate.viewContext.fetch(request) else {
                    return
                }
                for object in recipeToDelete {
                    AppDelegate.viewContext.delete(object)
                    }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteTableView.reloadData()
        self.favoriteList = RecipeFavorite.all
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? RecipeController{
            controller.recipeReceived = FavoriteController.recipeToSend
        }
    }
}

// MARK: - Extensions
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
        cell.favoriteStar.isHidden = false
        let urlToLoad = recipeResult.imageUrl()
        cell.recipeImage.sd_setImage(with: urlToLoad,placeholderImage: UIImage(systemName: "generique2"),
                                     options: .continueInBackground,completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeSelected = favoriteList[indexPath.row]
        FavoriteController.recipeToSend = recipeSelected
        self.performSegue(withIdentifier: "ShowFavoriteRecipeDetail", sender: nil)
    }
}
