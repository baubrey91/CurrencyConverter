//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 1/12/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit

class ConverterViewController : UIViewController {
    
    //MARK: -Variables/connections
    var cr = CurrencyRate(CurrencyOne: "error", CurrencyTwo: "error", CountryOne: "error", CountryTwo: "error", Rate: 0)
    
    @IBOutlet weak var currency1Label:  UILabel!
    @IBOutlet weak var currency2Label:  UILabel!
    @IBOutlet weak var currency1TF:     UITextField!
    @IBOutlet weak var currency2TF:     UITextField!
    @IBOutlet weak var flag1:           UIImageView!
    @IBOutlet weak var flag2:           UIImageView!

    override func viewDidLoad() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange,
                                               object: currency1TF,
                                               queue: OperationQueue.main,
                                               using: { _ in
                                                if (self.currency1TF.text?.isEmpty)! {
                                                    self.currency1TF.layer.borderWidth = 2
                                                    self.currency1TF.layer.borderColor = UIColor.red.cgColor
                                                } else {
                                                    self.currency1TF.layer.borderWidth = 0
                                                    self.currency2TF.text = String(Double(self.currency1TF.text!)! * self.cr.rate)
                                                    
                                                }
        })
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
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
