//
//  ExchangeCalculator.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation


var exchangeCalc = exchangeCalculator(foreignTheyWant: 0,
    foreignLocale:  localeListSingleton.getLocale("Prague"),
    homeLocale:  localeListSingleton.getLocale("United States (USA)")
)

class exchangeCalculator {
    
    var foreignLocale:Locale
    var homeLocale:Locale
    var exchangeRate:Double
    var foreignTheyWant:Double
    var precision:Double
    var parseHelperInstance = parseHelper()

    
    var localeList = localeListSingleton
    
    init(foreignTheyWant:Double, foreignLocale:Locale, homeLocale:Locale) {
       
        self.foreignTheyWant = foreignTheyWant
        self.exchangeRate = foreignLocale.country.exchangeRate / homeLocale.country.exchangeRate
        self.foreignLocale = foreignLocale
        self.homeLocale = homeLocale
        self.precision = homeLocale.country.precision
    }
    
    func updateForeignLocale (newLocale: Locale) {
        self.foreignLocale = newLocale
    }
    
    func calcTotalAmount (tippable:Double) -> Double {

        var foreignTaxRate:Double
        var foreignTipRate: Double
        
        if(foreignLocale.additionalTaxRate == nil) {
            foreignTaxRate = 0.0
        } else {
            foreignTaxRate = foreignLocale.additionalTaxRate!
        }
        
        if(foreignLocale.tipRate == nil) {
            foreignTipRate = 0.0
        } else {
            foreignTipRate = foreignLocale.tipRate!
        }

        
        // this should be the total cost all inclusive of what you'll end up paying
        var foreignTotalAmount:Double = (foreignTheyWant + (foreignTheyWant * foreignTaxRate) + (foreignTheyWant * (tippable * foreignTipRate)))/exchangeRate
        
        return foreignTotalAmount
    }

    func calcShouldFeelLike(tippable:Double) -> Double
    {
       
        var homeTaxRate:Double
        var homeTipRate: Double
        
        if(homeLocale.additionalTaxRate == nil) {
            homeTaxRate = 0.0
        } else {
            homeTaxRate = homeLocale.additionalTaxRate!
        }
        
        if(homeLocale.tipRate == nil) {
            homeTipRate = 0.0
        } else {
            homeTipRate = homeLocale.tipRate!
        }
        
        
        
        // this is what, given the foreign and local customs, you would see on a menu back home, but end up paying the same amount
        var shouldFeelLike = calcTotalAmount(tippable)/(1 + (tippable * homeTipRate) + homeTaxRate)
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
        var homeTipRate: Double
        
        if(homeLocale.tipRate == nil) {
            homeTipRate = 0.0
        } else {
            homeTipRate = homeLocale.tipRate!
        }
        
        
        // this is how much you'd tip back home
        var shouldTipLike = (tippable * homeTipRate) * calcShouldFeelLike(tippable)
        
        return shouldTipLike
    }
    
    func calcShouldTaxLike(tippable:Double) -> Double {
        var homeTaxRate:Double

        
        if(homeLocale.additionalTaxRate == nil) {
            homeTaxRate = 0.0
        } else {
            homeTaxRate = homeLocale.additionalTaxRate!
        }
        
        // this is how much you'd pay in tax back home
        var shouldTaxLike = homeTaxRate * calcShouldFeelLike(tippable)
        
        return shouldTaxLike
    }
    
    func calcExchangeRate() -> Double {
        //necessary as we need to recalculate whan a Locale pair changes
        exchangeRate = foreignLocale.country.exchangeRate / homeLocale.country.exchangeRate
        
        return exchangeRate
    }
    
}


