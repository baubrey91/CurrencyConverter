//
//  HomeViewController.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 1/12/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var rateDic: NSDictionary = [:]
    var currentCountry = "AUD" {
        didSet {
            self.title = currentCountry
        }
    }
    let countryArray = ["AUD", "BGN", "BRL", "CAD", "CHF", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HRK", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN", "RON", "RUB", "SEK", "SGD", "THB", "TRY", "USD", "ZAR"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = currentCountry
        loadCurrency()
        loadLatest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCurrency() {
        Service.sharedInstance.getJSON((LATEST_URL + currentCountry), completionHandler: {
            json in DispatchQueue.main.async {
                let rates = json["rates"] as? NSDictionary
                self.rateDic = rates!
                self.tableView.reloadData()
            }
        })
    }
    func loadLatest() {
        Service.sharedInstance.getJSON((HISTORY_URL + "2000-01-03"), completionHandler: {
            json in DispatchQueue.main.async {
                print(json)
            }
        })
    }
}
