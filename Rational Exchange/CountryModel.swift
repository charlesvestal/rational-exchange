//
//  CountryModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/30/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class country {
    var taxRate:Double
    var tipRate:Double
    var exchangeRate:Double
    var precision:Double
    var currencyCode:String
  
    init(taxRate:Double, tipRate:Double, exchangeRate:Double, precision:Double, currencyCode:String) {
        self.taxRate = taxRate
        self.tipRate = tipRate
        self.exchangeRate = exchangeRate
        self.precision = precision
        self.currencyCode = currencyCode
    }
    
}