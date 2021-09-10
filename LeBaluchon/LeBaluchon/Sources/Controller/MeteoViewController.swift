//
//  ViewController.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 10/09/2021.
//

import UIKit

class MeteoViewController: UIViewController {

    
    // MARK: - Outlets

    @IBOutlet weak var firstCityNameLabel: UILabel!
    @IBOutlet weak var firstCitytemperatureLabel: UILabel!
    @IBOutlet weak var firstCityDescriptionLabel: UILabel!
    @IBOutlet weak var firstCityImage: UIImageView!
    
    @IBOutlet weak var secondCityNameLabel: UILabel!
    @IBOutlet weak var secondCityTemperatureLabel: UILabel!
    @IBOutlet weak var secondCityDescriptionLabel: UILabel!
    @IBOutlet weak var secondCityImage: UIImageView!
    @IBOutlet weak var actualizeButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBAction func actualizeButton(_ sender: UIButton) {
    }

}

