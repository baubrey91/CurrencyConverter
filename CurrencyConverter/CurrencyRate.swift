//
//  CountryCurrency.swift
//  CurrencyConverter
//
//  Created by Brandon Aubrey on 1/12/17.
//  Copyright © 2017 Brandon Aubrey. All rights reserved.
//

import Foundation

class CurrencyRate {
    
    var currencyOne:    String
    var currencyTwo:    String
    var countryOne:     String
    var countryTwo:     String
    var rate:           Double
    
    init(CurrencyOne: String, CurrencyTwo: String, CountryOne: String, CountryTwo: String, Rate: Double){
        self.currencyOne = CurrencyOne
        self.currencyTwo = CurrencyTwo
        self.countryOne = CountryOne
        self.countryTwo = CountryTwo
        self.rate = Rate
    }
    
}
