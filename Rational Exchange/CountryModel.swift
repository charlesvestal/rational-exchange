//
//  CountryModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/14/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class Country {
    var name: String
    var currencyName: String
    var currencyCode: String
    var exchangeRate: Double
    var tipRate:Double?
    var additionalTaxRate: Double?
    var precision:Double
    
    
    init(name: String, currencyName: String, currencyCode: String, exchangeRate: Double, tipRate: Double?, additionalTaxRate:Double?, precision:Double)
    {
        self.name = name
        self.currencyName = currencyName
        self.currencyCode = currencyCode
        self.exchangeRate = exchangeRate
        self.tipRate = tipRate
        self.additionalTaxRate = additionalTaxRate
        self.precision = precision
     }
}