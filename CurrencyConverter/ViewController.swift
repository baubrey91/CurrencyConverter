//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 1/12/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import UIKit

var rateDic: NSDictionary = [:]

class ViewController: UIViewController {

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
        serviceCall(urlString: "https://api.fixer.io/latest?base=\(currentCountry)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func serviceCall(urlString: String) {
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                
                print(error!)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                    let rates = parsedData["rates"] as? NSDictionary
                    rateDic = rates!
                    DispatchQueue.main.async{
                        self.tableView.reloadData()
                    }
                    
                    
                } catch let error as NSError {
                    print(error)
                    
                }
            }
            
            }.resume()
    }

}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArray.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        currentCountry = countryArray[row]
        serviceCall(urlString: "https://api.fixer.io/latest?base=\(currentCountry)")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RateTableCell", for: indexPath) as! RateTableCell
        
        cell.countryLabel.text = countryArray[indexPath.row]

        if let rate = rateDic[countryArray[indexPath.row]]  {
            cell.rateLabel.text = String(describing: rate)
        } else {
            cell.rateLabel.text = "-"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "converterViewController") as! ConverterViewController
        vc.rate = rateDic[countryArray[indexPath.row]] as! Double
        vc.currency1 = currentCountry
        vc.currency1Value = 1.00
        vc.currency2 = countryArray[indexPath.row]
        vc.currency2Value = rateDic[countryArray[indexPath.row]] as! Double
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}




