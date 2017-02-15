//
//  HistoryViewController.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 2/14/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController {
    let HISTORY_URL  = "https://api.fixer.io/"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLatest()
    }
    
    func loadLatest() {
        Service.sharedInstance.getJSON((HISTORY_URL + "2000-01-03"), completionHandler: {
            json in DispatchQueue.main.async {
                print(json)
            }
        })
    }
}
