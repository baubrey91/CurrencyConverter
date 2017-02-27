//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 1/12/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit

class ConverterViewController : UIViewController, UITextFieldDelegate {
    
    //MARK: -Variables/connections
    var cr = CurrencyRate(CurrencyOne: "error", CurrencyTwo: "error", CountryOne: "error", CountryTwo: "error", Rate: 0)
    let currencyLogoDic : [String:String] = ["BGN":"лв", "BRL":"R$", "CHF":"chf", "CNY":"¥", "CZK":"Kč", "DKK":"kr", "EUR":"€", "GBP":"£", "HRK":"kn", "HUF":"Ft", "IDR":"Rp", "ILS":"₪", "INR":"₹", "JPY":"¥", "KRW":"₩", "MYR":"RM", "NOK":"kr", "PHP":"₱", "PLN":"zł", "RON":"lei", "RUB":"₽", "SEK":"kr", "THB":"฿", "TRY":"₤", "ZAR":"R"]
    
    var currencyLogoOne = "$"
    var currencyLogoTwo = "$"
    
    
    var calculatedValue:Double = 0 {
        didSet {
            currencyTwoTF.text =  currencyLogoTwo + String(calculatedValue)
        }
    }
    
    @IBOutlet weak var currencyOneLabel:  UILabel!
    @IBOutlet weak var currencyTwoLabel:  UILabel!
    @IBOutlet weak var currencyOneTF:     UITextField!
    @IBOutlet weak var currencyTwoTF:     UITextField!
    @IBOutlet weak var countryOneLabel:   UILabel!
    @IBOutlet weak var countryTwoLabel:   UILabel!
    @IBOutlet weak var flagOne:           UIImageView!
    @IBOutlet weak var flagTwo:           UIImageView!
    @IBOutlet weak var backgroundImage:   UIImageView!
    

    //MARK: view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyOneTF.tintColor = UIColor.clear
        currencyOneTF.becomeFirstResponder()
        backgroundImage.addBlurEffect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let logoOne = currencyLogoDic[cr.currencyOne]{
            currencyLogoOne = logoOne
        }
        if let logoTwo = currencyLogoDic[cr.currencyTwo]{
            currencyLogoTwo = logoTwo
        }
        
        currencyOneLabel.text =   cr.currencyOne
        currencyTwoLabel.text =   cr.currencyTwo
        countryOneLabel.text =    cr.countryOne
        countryTwoLabel.text =    cr.countryTwo
        currencyOneTF.text =      currencyLogoOne + String(1.00)
        currencyTwoTF.text =      currencyLogoTwo + String(cr.rate * 1.00)
        let flgImageOne =         cr.currencyOne
        flagOne.image =           UIImage(named: flgImageOne)
        let flgImageTwo =         cr.currencyTwo
        flagTwo.image =           UIImage(named: flgImageTwo)
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = currencyOneTF.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        if let characterCount = textField.text?.characters.count{
            
            if (characterCount > 10 && !string.isEmpty) {
                return false
            }
        }
        
        return (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) ? false : true

    }
    
    @IBAction func currencyOneTFChanged(textField: UITextField) {
        let currencyOneValue = currencyOneTF.text?.replacingOccurrences(of: currencyLogoOne, with: "")
        if (!(currencyOneValue!.isEmpty)){
            let value = Double(currencyOneValue!)
            calculatedValue = (cr.rate * value!)
            currencyOneTF.text = currencyLogoOne + currencyOneValue!
        }
        else {
            currencyOneTF.text = ""
            currencyTwoTF.text = currencyLogoTwo
        }
    }
}
