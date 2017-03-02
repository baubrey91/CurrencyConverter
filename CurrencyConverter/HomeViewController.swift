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
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    let service = Service.sharedInstance
    
    var rateDic = [String:Double]()
    var currentCountry = "AUD" {
        didSet {
            self.title = currentCountry
        }
    }
    let countryDic : [String:String] = ["AUD":"Australia", "BGN":"Bulgaria", "BRL":"Brazil", "CAD":"Canada", "CHF":"Switzerland", "CNY":"Chinese Yuan", "CZK":"Czech Republic", "DKK":"Denmark", "EUR":"Euro", "GBP":"British Pound", "HKD":"Hong Kong Dollar", "HRK":"Croatia", "HUF":"Hungary", "IDR":"Indonesia", "ILS":"Israel", "INR":"India", "JPY":"Japan", "KRW":"South Korea", "MXN":"Mexico", "MYR":"Malaysia", "NOK":"Norway", "NZD":"New Zealand", "PHP":"Philippines", "PLN":"Poland", "RON":"Romania", "RUB":"Russia", "SEK":"Sweden", "SGD":"Singapore", "THB":"Thailand", "TRY":"Turkey", "USD":"United States", "ZAR":"South Africa"]

    var countryArray = [String]()
    let LATEST_URL   = "https://api.fixer.io/latest?base="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = currentCountry
        activityMonitor.hidesWhenStopped = true
        countryArray = Array(countryDic.keys).sorted()
        backgroundImage.addBlurEffect()
        loadCurrency()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadCurrency() {
        activityMonitor.startAnimating()
        service.getJSON((LATEST_URL + currentCountry), completionHandler: {
            json in DispatchQueue.main.async {
                if let rates = json["rates"] as? NSDictionary{
                    self.rateDic = rates as! [String : Double]
                    self.tableView.reloadData()
                    self.activityMonitor.stopAnimating()
                } else {
                    let ac = UIAlertController(title: "UH OH!", message: "Something went wrong, please check internet connection", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    self.activityMonitor.stopAnimating()
                    self.present(ac, animated: true, completion: nil)
                    print(json)
                }
            }
        })
    }
}
