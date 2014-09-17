//
//  CountryModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/14/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class Country {
    var countryName: String
    var currencyName: String
    var currencyCode: String
    var exchangeRate: Double
    
    init(countryName: String, currencyName: String, currencyCode: String, exchangeRate: Double)
    {
        self.countryName = countryName
        self.currencyName = currencyName
        self.currencyCode = currencyCode
        self.exchangeRate = exchangeRate
     }
}