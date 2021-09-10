//
//  UIVIewController+Alert.swift
//  Le Baluchon
//
//  Created by ROUX Maxime on 28/08/2021.
//

import UIKit

// MARK: - Show generic alert

extension UIViewController {
    func showAlert(with message: String) {
        let alertController: UIAlertController = .init(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }

    func buttonFormatting(button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
    }
}
