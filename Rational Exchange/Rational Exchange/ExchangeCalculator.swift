//
//  ExchangeCalculator.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation


class exchangeCalculator {
    
    var foreignLocale:Locale
    var homeLocale:Locale
    var exchangeRate:Double
    var foreignTheyWant:Double
    var precision:Double

    
    var localeList = localeListSingleton
    
    init(foreignTheyWant:Double, foreignLocale:Locale, homeLocale:Locale) {
       
        self.foreignTheyWant = foreignTheyWant
        self.exchangeRate = foreignLocale.country.exchangeRate / homeLocale.country.exchangeRate
        self.foreignLocale = foreignLocale
        self.homeLocale = homeLocale
        self.precision = homeLocale.precision
    }
    
    func updateForeignLocale (newLocale: Locale) {
        self.foreignLocale = newLocale
    }
    
    func calcTotalAmount (tippable:Double) -> Double {
        // this should be the total cost all inclusive of what you'll end up paying
        var foreignTotalAmount:Double = (foreignTheyWant + (foreignTheyWant * foreignLocale.taxRate) + (foreignTheyWant * (tippable * foreignLocale.tipRate)))/exchangeRate
        
        return foreignTotalAmount
    }

    func calcShouldFeelLike(tippable:Double) -> Double
    {
        // this is what, given the foreign and local customs, you would see on a menu back home, but end up paying the same amount
        var shouldFeelLike = calcTotalAmount(tippable)/(1 + (tippable * homeLocale.tipRate) + homeLocale.taxRate)
        return shouldFeelLike
    }
    
    func calcShouldFeelLikeRounded(tippable:Double) -> Double
    {
        // take the "what it should feel like" number and round it to the nearest precision based on your homeLocale preferences
        var shouldFeelLikeRounded = precision * floor((calcShouldFeelLike(tippable)/precision)+0.5)
        return shouldFeelLikeRounded
    }
    
    func calcShouldTipLike(tippable:Double) -> Double
    {
        // this is how much you'd tip back home
        var shouldTipLike = (tippable * homeLocale.tipRate) * calcShouldFeelLike(tippable)
        
        return shouldTipLike
    }
    
    func calcShouldTaxLike(tippable:Double) -> Double {
        // this is how much you'd pay in tax back home
        var shouldTaxLike = homeLocale.taxRate * calcShouldFeelLike(tippable)
        
        return shouldTaxLike
    }
    
    func calcExchangeRate() -> Double {
        //necessary as we need to recalculate whan a Locale pair changes
        exchangeRate = foreignLocale.country.exchangeRate / homeLocale.country.exchangeRate
        
        return exchangeRate
    }
    
}


