//
//  RecipeController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import Foundation
import UIKit

class RecipeController: UIViewController {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var mainRecipeImage: UIImageView!
    @IBOutlet weak var mainCalories: UILabel!
    @IBOutlet weak var mainTime: UILabel!
    @IBOutlet weak var recipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func getDirection(_ sender: Any) {
    }
    
}

