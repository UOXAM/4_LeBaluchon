//
//  ExchangeWelcomeViewController.swift
//  Le Baluchon
//
//  Created by ROUX Maxime on 19/08/2021.
//

import UIKit

class CurrencyViewController: UIViewController {
    
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
            
    // MARK: - Properties
    private let exchangeService = CurrencyService()
    private var currencyListArray: [String] = []
    
    // MARK: - viewDidLoad & Network call (currency list)
    
    override func viewDidLoad() {
        // Dégradé de couleur :
//        let gradient = CAGradientLayer()
//        gradient.frame = finalCurrencyStackView.bounds
//        gradient.colors = [UIColor.purple.cgColor, UIColor.orange.cgColor]
//        gradient.locations = [0, 1]
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 1, y: 1)
//        view.layer.addSublayer(gradient)

        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        initialCurrencyPickerView.delegate = self
        initialCurrencyPickerView.dataSource = self
        finalCurrencyPickerView.delegate = self
        finalCurrencyPickerView.dataSource =  self
        
        activityIndicator.isHidden = true
        
        dateActualizationStackView.layer.borderWidth = 1
        dateActualizationStackView.layer.borderColor = UIColor.systemGray4.cgColor
        buttonFormatting(button: conversionButton)
//        stackViewFormatting(stackView: initialCurrencyStackView)
//        stackViewFormatting(stackView: finalCurrencyStackView)
        
        // Network call to keep list of currencies available
        exchangeService.fetchCurrencyList { [weak self] result in
            
            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
                self?.conversionButton.isEnabled = false

                switch result {
                case .success(let currencyList):
                    // Transform dictionary to array
                    self?.currencyListArray = currencyList.symbols.map { "\($0.key) : \($0.value)" }
//                    { "\($0) : \($1)" }
                    // Sort the array by alphabetical order
                    self?.currencyListArray = self!.currencyListArray.sorted { $0 < $1 }
                    // PickerView : actualize
                    self?.initialCurrencyPickerView.reloadAllComponents()
                    self?.finalCurrencyPickerView.reloadAllComponents()
                    // PickerView : select EUR & USD
                    let euroCurrencyCode = self?.currencyListArray.firstIndex(of: "EUR : Euro") ?? 0
                    self?.initialCurrencyPickerView.selectRow(euroCurrencyCode, inComponent: 0, animated: false)
                    let usdCurrencyCode = self?.currencyListArray.firstIndex(of: "USD : United States Dollar") ?? 1
                    self?.finalCurrencyPickerView.selectRow(usdCurrencyCode, inComponent: 0, animated: false)

                    self?.activityIndicator.stopAnimating()

//                    print(currencyListArray)
                case.failure(let error):
                    self?.showAlert(with: error.description)
                    self?.activityIndicator.stopAnimating()

                }
                self?.conversionButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
                
            }
        }
    }
    
    
    // MARK: - Action & Network
    
    @IBAction func conversionButton(_ sender: UIButton) {
        
        // Properties
        let initialCurrencyCode : String = getCurrencyCode(pickerView: initialCurrencyPickerView)
        let finalCurrencyCode : String = getCurrencyCode(pickerView: finalCurrencyPickerView)
        
        guard let initialAmount :Double = Double(fromAmountTextField.text!) else {return}

        // Network call to keep currency rates
        exchangeService.fetchCurrencyRates(initialCurrency: initialCurrencyCode, finalCurrency: finalCurrencyCode) { [weak self] result in

            DispatchQueue.main.async {
                self?.activityIndicator.startAnimating()
                self?.conversionButton.isEnabled = false
                switch result {
                case .success(let currencyRates):
                                        
                    // Search the rate of the initial currency in the result of the network call
                    guard let initialRate :Double = Double?(currencyRates.rates[initialCurrencyCode]!) else {return}
                    // Search the rate of the final currency in the result of the network call
                    guard let finalRate :Double = currencyRates.rates[finalCurrencyCode] else {return}

                    // Calculate the result amount converted
                    let result = self?.exchangeService.calculateAmount(initialAmount: initialAmount, initialRate: initialRate, finalRate: finalRate)
                    // Show the result with 2 decimals
                    self?.toAmountLabel.text = String(format: "%.02f", result!)
                    self?.dateCurrencyRateLabel.text = String("\(currencyRates.date) ")
                    print(currencyRates.date)
                    self?.activityIndicator.stopAnimating()

                case.failure(let error):
                    self?.showAlert(with: error.description)
                    self?.activityIndicator.stopAnimating()
                }
                self?.conversionButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    private
    func getCurrencyCode(pickerView: UIPickerView?) -> String {
        guard let currencyIndex = pickerView?.selectedRow(inComponent: 0) else {return ""}
        let currency :String = currencyListArray[currencyIndex]
        return currency.components(separatedBy: " : ")[0]
    }
    
}

    // MARK: - PickerView

extension CurrencyViewController : UIPickerViewDelegate, UIPickerViewDataSource {
        
    // Number of elements to show (column)
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
                
    // Number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyListArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let string = currencyListArray[row]
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.deepBlue])
    }
    


        
}
