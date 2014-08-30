//
//  TipCalculadorModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    
    var country1:country
    var country2:country
    var exchangeRate:Double
    var foreignTheyWant:Double
    var foreignTaxRate:Double
    var foreignTipRate:Double
    var homeTaxRate:Double
    var homeTipRate:Double
    
    init(foreignTheyWant:Double, exchangeRate:Double, country1:country, country2:country) {
        self.foreignTheyWant = foreignTheyWant
        self.exchangeRate = exchangeRate
        self.country1 = country1
        self.country2 = country2
        self.foreignTaxRate = 0.01 * country1.taxRate
        self.foreignTipRate = 0.01 * country1.tipRate
        self.homeTaxRate  = 0.01 * country2.taxRate
        self.homeTipRate  = 0.01 * country2.tipRate
    }
    
    func calcTotalAmount () -> Double {
        var totalamount:Double = (foreignTheyWant * (1.0 + foreignTaxRate + foreignTipRate) / exchangeRate)
        return totalamount
    }
    
    func calcShouldFeelLike() -> Double
    {
        var shouldFeelLike = calcTotalAmount()/(1.0 + homeTaxRate + homeTipRate)
        return shouldFeelLike
    }
    
    func calcShouldTipLike() -> Double
    {
        var shouldTipLike = homeTipRate * calcShouldFeelLike()
        return shouldTipLike
    }
    
    func calcShouldTaxLike() -> Double {
        var shouldTaxLike = homeTaxRate * calcShouldFeelLike()
        return shouldTaxLike
    }
    
    
    
}


