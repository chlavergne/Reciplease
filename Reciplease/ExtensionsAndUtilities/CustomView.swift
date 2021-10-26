//
//  CustomView.swift
//  Reciplease
//
//  Created by Christophe Expleo on 09/10/2021.
//

import UIKit

final class CustomView: UIView {

// Used for the Calories and TotalTime View in the right corner of the recipe
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadiusBorder()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setRadiusBorder()
    }

    // MARK: - Method
    func setRadiusBorder() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
    }
}
