//
//  ExtensionUITableView.swift
//  Reciplease
//
//  Created by Christophe Expleo on 19/10/2021.
//

import UIKit

// MARK: - Extensions UITableView for placeHolder Text when empty
extension UITableView {
    func setNoDataPlaceholder(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.text = message
        label.font = UIFont(name: "Noteworthy Light", size: 20.0)
        label.textAlignment = .center
        label.sizeToFit()

        self.isScrollEnabled = false
        self.backgroundView = label
        self.separatorStyle = .none
    }
}
extension UITableView {
    func removeNoDataPlaceholder() {
        self.isScrollEnabled = true
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
