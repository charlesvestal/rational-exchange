//
//  CountryModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/14/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class Country {
    var currencyName: String
    var currencyCode: String
    var exchangeRate: Double
    
    init(currencyName: String, currencyCode: String, exchangeRate: Double)
    {
        self.currencyName = currencyName
        self.currencyCode = currencyCode
        self.exchangeRate = exchangeRate
     }
}