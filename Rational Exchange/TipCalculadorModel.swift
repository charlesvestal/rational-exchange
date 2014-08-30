//
//  TipCalculadorModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    
    var exchangeRate:Double
    var foreignTheyWant:Double
    var foreignTaxRate:Double
    var foreignTipRate:Double
    var homeTaxRate:Double
    var homeTipRate:Double
    
    init(foreignTheyWant:Double, exchangeRate:Double, foreignTaxRate:Double, foreignTipRate:Double, homeTaxRate:Double, homeTipRate:Double) {
        self.foreignTheyWant = foreignTheyWant
        self.exchangeRate = exchangeRate
        self.foreignTaxRate = 0.01 * foreignTaxRate
        self.foreignTipRate = 0.01 * foreignTipRate
        self.homeTaxRate  = 0.01 * homeTaxRate
        self.homeTipRate  = 0.01 * homeTipRate
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


