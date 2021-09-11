//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 19/08/2021.
//

import UIKit

class TranslationViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var translationButton: UIButton!
    @IBOutlet weak var initialTextView: UITextView!
    @IBOutlet weak var finalLanguageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties

    private let translationService = TranslationService()
    
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss Keybpard
        self.hideKeyboardWhenTappedAround()
        
        activityIndicator.isHidden = true
        buttonFormatting(button: translationButton)
        
        // Formatting
        initialTextView.layer.borderWidth = 1
        initialTextView.layer.borderColor = UIColor.systemGray4.cgColor
        finalLanguageLabel.layer.borderWidth = 1
        finalLanguageLabel.layer.borderColor = UIColor.systemGray4.cgColor
        
        initialTextView.delegate = self
    }
    
    // MARK: - Formatting TextView
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        initialTextView.centerVerticalText()
    }
    
    // MARK: - Action & Network call (rates))

    @IBAction func translationButton(_ sender: UIButton) {
                
        guard let initialText :String = initialTextView.text else {return}

        // Network call to get the text translated
        translationService.fetchTextTranslation(text: initialText) { [weak self] result in

            DispatchQueue.main.async {
                // Conversion Button not available
                self?.activityIndicator.startAnimating()
                self?.translationButton.isEnabled = false
                
                switch result {
                
                case .success(let googleTranslation):
                    self?.finalLanguageLabel.text = googleTranslation.data.translations[0].translatedText

                case.failure(let error):
                    self?.showAlert(with: error.description)
                }
                // Conversion Button available
                self?.translationButton.isEnabled = true
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
}
