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
    var dateFormatter = DateFormatter()
    let today = NSDate() as Date
    var strDate = "2001-01-01"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        strDate = dateFormatter.string(from: today)
        datePicker.date = today
        datePicker.maximumDate = today
        strDate = dateFormatter.string(from: NSDate() as Date)
        loadCurrency()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }


    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePicked(_ sender: Any) {
        strDate = dateFormatter.string(from: datePicker.date)
        loadCurrency()
        //self.selectedDate.text = strDate
    }
    
    override func loadCurrency() {
        activityMonitor.startAnimating()
        service.getJSON((HISTORY_URL + strDate), completionHandler: {
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
        
        setCellColor(cell: cell, blackBackground: (indexPath.row % 2 == 0))

        return cell
    }
}


