//
//  CustomView.swift
//  Reciplease
//
//  Created by Christophe Expleo on 09/10/2021.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRadiusBorder()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setRadiusBorder()
    }
    
    func setRadiusBorder() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
    }
}
