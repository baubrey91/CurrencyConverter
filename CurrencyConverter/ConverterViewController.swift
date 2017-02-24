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
    
    var calculatedValue:Double = 0 {
        didSet {
            currencyTwoTF.text = String(calculatedValue)
        }
    }
    
    @IBOutlet weak var currencyOneLabel:  UILabel!
    @IBOutlet weak var currencyTwoLabel:  UILabel!
    @IBOutlet weak var currencyOneTF:     UITextField!
    @IBOutlet weak var currencyTwoTF:     UITextField!
    @IBOutlet weak var flagOne:           UIImageView!
    @IBOutlet weak var flagTwo:           UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currencyOneTF.becomeFirstResponder()
        currencyOneLabel.text =   cr.currencyOne
        currencyTwoLabel.text =   cr.currencyTwo
        currencyOneTF.text =      String(1.00)
        currencyTwoTF.text =      String(cr.rate * 1.00)
        let flgImageOne =         cr.currencyOne
        flagOne.image =           UIImage(named: flgImageOne)
        let flgImageTwo =         cr.currencyTwo
        flagTwo.image =           UIImage(named: flgImageTwo)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = currencyOneTF.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        return (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) ? false : true
    }
    
    @IBAction func currencyOneTFChanged(textField: UITextField) {
        if (!(currencyOneTF.text?.isEmpty)!){
            let value = Double(currencyOneTF.text!)
            calculatedValue = (cr.rate * value!)
        }
    }
}

