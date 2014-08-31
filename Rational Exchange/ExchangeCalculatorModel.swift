//
//  exchangeCalculatorModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class exchangeCalculatorModel {
    
    var foreignCountry:country
    var homeCountry:country
    var exchangeRate:Double
    var foreignTheyWant:Double
    var foreignTaxRate:Double
    var foreignTipRate:Double
    var homeTaxRate:Double
    var homeTipRate:Double
    var precision:Double

    
    init(foreignTheyWant:Double, foreignCountry:country, homeCountry:country) {
        self.foreignTheyWant = foreignTheyWant
        self.exchangeRate = foreignCountry.exchangeRate / homeCountry.exchangeRate
        self.foreignCountry = foreignCountry
        self.homeCountry = homeCountry
        self.foreignTaxRate = foreignCountry.taxRate
        self.foreignTipRate = foreignCountry.tipRate
        self.homeTaxRate  =  homeCountry.taxRate
        self.homeTipRate  =  homeCountry.tipRate
        self.precision = homeCountry.precision
    }

    
    func calcTotalAmount (tippable:Double) -> Double {
        var totalamount:Double = (foreignTheyWant * (1.0 + foreignTaxRate * (tippable * foreignTipRate)) / exchangeRate)
        return totalamount
    }
    
    func calcShouldFeelLike(tippable:Double) -> Double
    {
        var shouldFeelLike = calcTotalAmount(tippable)/(1.0 + homeTaxRate + (tippable * homeTipRate))
        shouldFeelLike = precision * floor((shouldFeelLike/precision)+0.5)
        return shouldFeelLike
    }
    
    func calcShouldTipLike(tippable:Double) -> Double
    {
        var shouldTipLike = (tippable * homeTipRate) * calcShouldFeelLike(tippable)
        return shouldTipLike
    }
    
    func calcShouldTaxLike(tippable:Double) -> Double {
        var shouldTaxLike = homeTaxRate * calcShouldFeelLike(tippable)
        return shouldTaxLike
    }
    
    func calcExchangeRate() -> Double {
        exchangeRate = foreignCountry.exchangeRate / homeCountry.exchangeRate
        return exchangeRate
    }
    
}


