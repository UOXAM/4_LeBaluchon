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
    @IBOutlet weak var firstCityTemperatureLabel: UILabel!
    @IBOutlet weak var firstCityDescriptionLabel: UILabel!
    @IBOutlet weak var firstCityImage: UIImageView!
    
    @IBOutlet weak var secondCityNameLabel: UILabel!
    @IBOutlet weak var secondCityTemperatureLabel: UILabel!
    @IBOutlet weak var secondCityDescriptionLabel: UILabel!
    @IBOutlet weak var secondCityImage: UIImageView!
    @IBOutlet weak var actualizeButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Properties

    private let meteoService = MeteoService()
    
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        actualizeCurrentWeather()
        buttonFormatting(button: actualizeButton)
    }
    
    // MARK: - Network call

    func  actualizeCurrentWeather() {
        meteoService.fetchCurrentWeather { [weak self] result in
                       
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
                self?.actualizeButton.isEnabled = false

                
               switch result {
               case .success(let meteo):
                
                // Fill weather info for the first city (Montpellier)
                self?.fillWeatherInfo(meteo: meteo, city: self?.firstCityNameLabel, cityIndex: 0, temperature: self?.firstCityTemperatureLabel, description: self?.firstCityDescriptionLabel, image: self?.firstCityImage)
                
                // Fill weather info for the second city (New York)
                self?.fillWeatherInfo(meteo: meteo,city: self?.secondCityNameLabel, cityIndex: 1, temperature: self?.secondCityTemperatureLabel, description: self?.secondCityDescriptionLabel, image: self?.secondCityImage)

               case.failure(let error):
                   self?.showAlert(with: error.description)
               }
                
                self?.activityIndicator.stopAnimating()
                self?.actualizeButton.isEnabled = true

           }
       }
    }
    
    // MARK: - Action

    @IBAction func actualizeButton(_ sender: UIButton) {
        actualizeCurrentWeather()
    }
    
    func fillWeatherInfo(meteo: Meteo, city: UILabel?, cityIndex: Int, temperature: UILabel?, description: UILabel?, image: UIImageView?) {
        
        // Verify there are same cities in Network call and UILabel
        if city?.text?.components(separatedBy: ", ")[0] == meteo.list[cityIndex].name
            && city?.text?.components(separatedBy: ", ")[1] == meteo.list[cityIndex].sys.country {
                                    
            // Verify there are same cities in Network call and UILabel
            temperature?.text = "\(Int(meteo.list[cityIndex].main.temp)) °C"
            description?.text = meteo.list[cityIndex].weather[0].weatherDescription.capitalized
            let icon = String(meteo.list[cityIndex].weather[0].icon)
            let urlIcon = URL(string: "http://openweathermap.org/img/w/\(icon).png")
            image?.load(url: urlIcon!)
            
        }else{
            
            return
        }
    }

}

