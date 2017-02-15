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
            currency2TF.text = String(calculatedValue)
        }
    }
    
    @IBOutlet weak var currency1Label:  UILabel!
    @IBOutlet weak var currency2Label:  UILabel!
    @IBOutlet weak var currency1TF:     UITextField!
    @IBOutlet weak var currency2TF:     UITextField!
    @IBOutlet weak var flag1:           UIImageView!
    @IBOutlet weak var flag2:           UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        currency1Label.text =   cr.currencyOne
        currency2Label.text =   cr.currencyTwo
        currency1TF.text =      String(1.00)
        currency2TF.text =      String(cr.rate * 1.00)
        let flgImageOne =         cr.currencyOne
        flag1.image =           UIImage(named: flgImageOne)
        let flgImageTwo =         cr.currencyTwo
        flag2.image =           UIImage(named: flgImageTwo)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = currency1TF.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        return (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) ? false : true
    }
    
    @IBAction func currencyOneTFChanged(textField: UITextField) {
        
        if (currency1TF.text?.isEmpty)! {
            
        }else {
            let value = Double(currency1TF.text!)
            calculatedValue = (cr.rate * value!)
        }
    }
    
    
}
