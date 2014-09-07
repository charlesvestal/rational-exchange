//
//  CountryListModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/7/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class CountryList {
    var countryListDict:Dictionary<String, AnyObject>
    
    init() {
        self.countryListDict = [
            "Prague":  Country(name:"Prague", taxRate: 0.0, tipRate: 0.0, exchangeRate: 21.31, precision: 1, currencyShort:"CZK"),
            "USA":  Country(name:"USA", taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyShort:"USD"),
            "Portland":  Country(name:"USA", taxRate: 0.0, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyShort:"USD"),
            "Euro": Country(name:"Euro", taxRate: 0, tipRate: 0, exchangeRate: 0.76, precision: 1, currencyShort:"EUR"),
            "Norway": Country(name:"Norway", taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1, currencyShort:"NOK"),
            "Magic10": Country(name:"Magic10", taxRate: 0.1, tipRate: 0.1, exchangeRate: 1, precision: 1, currencyShort:"M10"),
            "Magic20": Country(name:"Magic20", taxRate: 0.2, tipRate: 0.2, exchangeRate: 1, precision: 1, currencyShort:"M20")
        ]
    }
    
}