//
//  HomeViewController.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 1/12/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import UIKit

var rateDic: NSDictionary = [:]

class HomeViewController: UIViewController {

    @IBOutlet weak var countryPicker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    var currentCountry = "AUD"
    
    let countryArray = ["AUD",
                        "BGN",
                        "BRL",
                        "CAD",
                        "CHF",
                        "CNY",
                        "CZK",
                        "DKK",
                        "EUR",
                        "GBP",
                        "HKD",
                        "HRK",
                        "HUF",
                        "IDR",
                        "ILS",
                        "INR",
                        "JPY",
                        "KRW",
                        "MXN",
                        "MYR",
                        "NOK",
                        "NZD",
                        "PHP",
                        "PLN",
                        "RON",
                        "RUB",
                        "SEK",
                        "SGD",
                        "THB",
                        "TRY",
                        "USD",
                        "ZAR"]

    override func viewDidLoad() {
        super.viewDidLoad()
        HttpService.getJSON("https://api.fixer.io/latest?base=\(currentCountry)")
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




