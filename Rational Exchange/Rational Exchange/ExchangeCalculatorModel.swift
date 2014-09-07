//
//  exchangeCalculatorModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class exchangeCalculatorModel {
    
    var foreignCountry:Country
    var homeCountry:Country
    var exchangeRate:Double
    var foreignTheyWant:Double
    var foreignTaxRate:Double
    var foreignTipRate:Double
    var homeTaxRate:Double
    var homeTipRate:Double
    var precision:Double

    init(foreignTheyWant:Double, foreignCountry:Country, homeCountry:Country) {
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
        // this should be the total cost all inclusive of what you'll end up paying
        var foreignTotalAmount:Double = (foreignTheyWant + (foreignTheyWant * foreignTaxRate) + (foreignTheyWant * (tippable * foreignTipRate)))/exchangeRate
        
        return foreignTotalAmount
    }

    func calcShouldFeelLike(tippable:Double) -> Double
    {
        // this is what, given the foreign and local customs, you would see on a menu back home, but end up paying the same amount
        var shouldFeelLike = calcTotalAmount(tippable)/(1 + (tippable * homeTipRate) + homeTaxRate)
        
        return shouldFeelLike
    }
    
    func calcShouldFeelLikeRounded(tippable:Double) -> Double
    {
        // take the "what it should feel like" number and round it to the nearest precision based on your homeCountry preferences
        var shouldFeelLikeRounded = precision * floor((calcShouldFeelLike(tippable)/precision)+0.5)
        
        return shouldFeelLikeRounded
    }
    
    func calcShouldTipLike(tippable:Double) -> Double
    {
        // this is how much you'd tip back home
        var shouldTipLike = (tippable * homeTipRate) * calcShouldFeelLike(tippable)
        
        return shouldTipLike
    }
    
    func calcShouldTaxLike(tippable:Double) -> Double {
        // this is how much you'd pay in tax back home
        var shouldTaxLike = homeTaxRate * calcShouldFeelLike(tippable)
        
        return shouldTaxLike
    }
    
    func calcExchangeRate() -> Double {
        //necessary as we need to recalculate whan a country pair changes
        exchangeRate = foreignCountry.exchangeRate / homeCountry.exchangeRate
        
        return exchangeRate
    }
    
}


