//
//  CountryModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/30/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class Country {
    var name:String
    var taxRate:Double
    var tipRate:Double
    var exchangeRate:Double
    var precision:Double
    var currencyShort:String
    
  
    init(name:String, taxRate:Double, tipRate:Double, exchangeRate:Double, precision:Double, currencyShort:String) {
        self.name = name
        self.taxRate = taxRate
        self.tipRate = tipRate
        self.exchangeRate = exchangeRate
        self.precision = precision
        self.currencyShort = currencyShort
         }
    
}