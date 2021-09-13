//
//  UIViewController+Formatting.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 13/09/2021.
//

import UIKit

// MARK: - Formatting

extension UIViewController {

    func buttonFormatting(button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    func borderFormatting(element: UIView) {
        element.layer.cornerRadius = 5
        element.layer.borderWidth = 1
        element.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
}
