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
    var taxRate:Double
    var tipRate:Double
    var precision:Double
 
    var country: Country
    
  
    init(name:String, taxRate:Double, tipRate:Double, precision:Double, countryName:Country) {
        self.name = name
        self.country = countryName
        self.taxRate = taxRate
        self.tipRate = tipRate
 //       self.exchangeRate = countryName.exchangeRate
        self.precision = precision
//        self.currencyName = countryName.currencyName
//        self.currencyCode = countryName.currencyCode
         }
    
}