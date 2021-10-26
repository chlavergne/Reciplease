//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Christophe Expleo on 06/10/2021.
//

import UIKit

final class RecipeTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var favoriteStar: UIImageView!

    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
