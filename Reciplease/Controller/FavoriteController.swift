//
//  FavoriteController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 05/10/2021.
//

import Foundation
import UIKit

class FavoriteController: UIViewController {
    
    static let favoriteRecipeCellId = "recipeFavCell"
    var favoriteList: [RecipeFavorite] = []
    private var recipeFavorite: RecipeFavorite?
    
    init(recipeFavorite: RecipeFavorite) {
        self.recipeFavorite = recipeFavorite
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    @IBOutlet weak var favoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register Cell
        favoriteTableView.register(UINib.init(nibName: SearchResultsController.recipeCellId, bundle: nil),
                                  forCellReuseIdentifier: SearchResultsController.recipeCellId)
        favoriteTableView.separatorColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteTableView.reloadData()
    }
}
