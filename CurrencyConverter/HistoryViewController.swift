//
//  HistoryViewController.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 2/14/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: HomeViewController {
    let HISTORY_URL  = "https://api.fixer.io/"

    
    /*override func viewDidLoad() {
        super.viewDidLoad()
        loadCurrenct()
    }*/
    
    override func loadCurrency() {
        activityMonitor.startAnimating()
        Service.sharedInstance.getJSON((HISTORY_URL + "2000-01-03"), completionHandler: {
            json in DispatchQueue.main.async{
                let rates = json["rates"] as? NSDictionary
                self.rateDic = rates!
                self.tableView.reloadData()
                self.activityMonitor.stopAnimating()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RateTableCell", for: indexPath) as! RateTableCell
        
        cell.countryLabel.text = countryArray[indexPath.row] + "-" + countryDic[countryArray[indexPath.row]]!
        
        if let rate = rateDic[countryArray[indexPath.row]]  {
            cell.rateLabel.text = String(describing: rate)
        } else {
            cell.rateLabel.text = "-"
        }
        
        return cell
    }
}
