//
//  UIPickerView.swift
//  LeBaluchon
//
//  Created by ROUX Maxime on 13/09/2021.
//

import UIKit

// MARK: - PickerView

extension CurrencyViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
// Number of elements to show (columns)
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
