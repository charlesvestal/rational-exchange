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
  
    init(taxRate:Double, tipRate:Double) {
        self.taxRate = taxRate
        self.tipRate = tipRate
    }
    
}