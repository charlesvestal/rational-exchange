//
//  CountryModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/30/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

struct Locale {
    var name:String
    var country: String
    var taxRate:Double
    var tipRate:Double
    var exchangeRate:Double
    var precision:Double
    var currencyName: String
    var currencyCode:String
    
  
    init(name:String, country:String, taxRate:Double, tipRate:Double, exchangeRate:Double, precision:Double, currencyName: String, currencyCode:String) {
        self.name = name
        self.country = country
        self.taxRate = taxRate
        self.tipRate = tipRate
        self.exchangeRate = exchangeRate
        self.precision = precision
        self.currencyName = currencyName
        self.currencyCode = currencyCode
         }
    
}