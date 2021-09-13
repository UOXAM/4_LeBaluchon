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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var finalTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    
    // MARK: - Properties

    private let translationService = TranslationService()
    
    
    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Dismiss Keybpard
        self.hideKeyboardWhenTappedAround()
        
        activityIndicator.isHidden = true
        buttonFormatting(button: translationButton)
//        clearButton.isHidden = true
        
        // Formatting
        borderFormatting(element: initialTextView)
        borderFormatting(element: finalTextView)
        
        initialTextView.delegate = self
    }
    
//    func viewDidAppear() {
//        if initialTextView.text != "" {
//            clearButton.isHidden = false
//        } else {
//            clearButton.isHidden = true
//        }
//    }
    

    // MARK: - Formatting TextView
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        initialTextView.centerVerticalText()
        finalTextView.centerVerticalText()
    }
    
    // MARK: - Action & Network call (rates))
    @IBAction func clearButton(_ sender: UIButton) {
        initialTextView.text = ""
        finalTextView.text = ""
    }
    
    @IBAction func translationButton(_ sender: UIButton) {
        guard initialTextView.text != "" else {return}
        
        guard let initialText: String = initialTextView.text else {
            return
        }

        // Network call to get the text translated
        translationService.fetchTextTranslation(text: initialText) { [weak self] result in

            DispatchQueue.main.async {
                // Conversion Button not available
                self?.activityIndicator.startAnimating()
                self?.translationButton.isEnabled = false
                
                switch result {
                
                case .success(let googleTranslation):
                    self?.finalTextView.text = googleTranslation.data.translations[0].translatedText

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
