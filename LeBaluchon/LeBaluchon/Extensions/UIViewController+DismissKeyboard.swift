//
//  UIViewController+DismissKeyboard.swift
//  Le Baluchon
//
//  Created by ROUX Maxime on 07/09/2021.
//

import UIKit

extension UIViewController {

    //Put this piece of code anywhere you like
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
