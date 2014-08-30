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
  
    init(taxRate:Double, tipRate:Double, exchangeRate:Double) {
        self.taxRate = taxRate
        self.tipRate = tipRate
        self.exchangeRate = exchangeRate
    }
    
}