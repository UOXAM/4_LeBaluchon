//
//  ExchangeWelcomeViewController.swift
//  Le Baluchon
//
//  Created by ROUX Maxime on 19/08/2021.
//

import UIKit

class CurrencyWelcomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var fromAmountTextField: UITextField!
    @IBOutlet weak var toAmountLabel: UILabel!
    @IBOutlet weak var finalCurrencyPickerView: UIPickerView!
    @IBOutlet weak var initialCurrencyPickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var conversionButton: UIButton!
    @IBOutlet weak var initialCurrencyStackView: UIStackView!
    @IBOutlet weak var finalCurrencyStackView: UIStackView!
    @IBOutlet weak var dateCurrencyRateLabel: UILabel!
    @IBOutlet weak var dateActualizationStackView: UIStackView!
    
    
    
    // MARK: - Action & Network

    @IBAction func conversionButton(_ sender: UIButton) {

    }
    

}
