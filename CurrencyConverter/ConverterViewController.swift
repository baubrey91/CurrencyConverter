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
    
    var rate:Double =       1
    var currency1 =         ""
    var currency2 =         ""
    var currency1Value =    1.00
    var currency2Value =    1.00
    var canConvert =        true
    
    @IBOutlet weak var currency1Label:  UILabel!
    @IBOutlet weak var currency2Label:  UILabel!
    @IBOutlet weak var currency1TF:     UITextField!
    @IBOutlet weak var currency2TF:     UITextField!

    override func viewDidLoad() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange,
                                               object: currency1TF,
                                               queue: OperationQueue.main,
                                               using: { _ in
                                                if self.currency1TF.text == "" {
                                                    self.canConvert = false
                                                    self.currency1TF.layer.borderWidth = 2
                                                    self.currency1TF.layer.borderColor = UIColor.red.cgColor
                                                } else {
                                                    self.currency1TF.layer.borderWidth = 0
                                                    self.canConvert = true
                                                    self.currency2Value = Double(self.currency1TF.text!)! * self.rate
                                                    self.currency2TF.text = String(self.currency2Value)
                                                    
                                                }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        currency1Label.text =   currency1
        currency2Label.text =   currency2
        currency1TF.text =      String(currency1Value)
        currency2TF.text =      String(currency2Value)
    }
    
    @IBAction func convertButton(_ sender: Any) {
        if canConvert {
            currency2Value = Double(currency1TF.text!)! * rate
            currency2TF.text = String(currency2Value)
        }
        else {
            print("disabled")
        }
    }
    
    deinit {
        
    }
}
