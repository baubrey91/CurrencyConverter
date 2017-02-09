//
//  HomeCollection:Table.swift
//  CurrencyConverter
//
//  Created by Brandon on 2/8/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
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

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
}
