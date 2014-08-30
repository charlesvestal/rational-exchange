//
//  TipCalculadorModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    
    var foreignCountry:country
    var homeCountry:country
    var exchangeRate:Double
    var foreignTheyWant:Double
    var foreignTaxRate:Double
    var foreignTipRate:Double
    var homeTaxRate:Double
    var homeTipRate:Double
    
    init(foreignTheyWant:Double, foreignCountry:country, homeCountry:country) {
        self.foreignTheyWant = foreignTheyWant
        self.exchangeRate = foreignCountry.exchangeRate / homeCountry.exchangeRate
        self.foreignCountry = foreignCountry
        self.homeCountry = homeCountry
        self.foreignTaxRate = foreignCountry.taxRate
        self.foreignTipRate = foreignCountry.tipRate
        self.homeTaxRate  =  homeCountry.taxRate
        self.homeTipRate  =  homeCountry.tipRate
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


