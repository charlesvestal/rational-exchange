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
    var additionalTaxRate:Double?
    var tipRate:Double?
    var tipString:String?
    
    var country: Country
    
  
    init(name:String!, additionalTaxRate:Double?, tipRate:Double?, tipString:String?, country:Country!) {
        self.name = name
        self.additionalTaxRate = additionalTaxRate
        self.tipRate = tipRate
        self.country = country
        if((tipString) != nil) {
            self.tipString = tipString
        } else {
            self.tipString = country.tipString
        }
        
    }
    
}