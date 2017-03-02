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
        let imgString = countryArray[indexPath.row]

        cell.countryLabel.text = countryArray[indexPath.row]
        
        if let rate = rateDic[countryArray[indexPath.row]]  {
            cell.rateLabel.text = String(describing: rate.roundTo(places: 4))
        } else {
            cell.rateLabel.text = "-"
        }
        cell.flagImage.image = UIImage(named: imgString)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let rate = rateDic[countryArray[indexPath.row]] else {
            return
        }
        let currencyTwo = countryArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "converterViewController") as! ConverterViewController
        let cr = CurrencyRate(CurrencyOne: currentCountry, CurrencyTwo: currencyTwo, CountryOne: countryDic[currentCountry]!, CountryTwo: countryDic[currencyTwo]!, Rate: rate)
        vc.cr = cr
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flagCell", for: indexPath) as! FlagCollectionCell
        let imgString = countryArray[indexPath.row]
        cell.flagImage.image = UIImage(named: imgString)
        cell.flagLabel.text = countryArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentCountry = countryArray[indexPath.row]
        loadCurrency()
    }
}
