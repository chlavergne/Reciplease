//
//  ExtensionUIViewController.swift
//  Reciplease
//
//  Created by Christophe Expleo on 22/10/2021.
//

import UIKit

// MARK: - Extension UIViewController
extension UIViewController {
    func presentAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
