//
//  parseHelper.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/26/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class parseHelper:NSObject {
    
    let delegate:ViewController?
    
    func parseInit() {
        println("Getting the latest config...");
        PFConfig.getConfigInBackgroundWithBlock {
            (var config: PFConfig!, error) -> Void in
            if (error == nil) {
                println("Yay! Config was fetched from the server.")
            } else {
                println("Failed to fetch. Using Cached Config.")
                config = PFConfig.currentConfig()
            }
            
            if let localeInfo = config["localeInfo"] as? PFFile {
                println("locale info found")
                
                let jsonData = JSONValue(localeInfo.getData())
                self.parseLocaleJSON(jsonData)
            }
            println("updating UI")
            self.delegate?.updateUI()
            println(exchangeCalc.localeList.getCountry("Germany").additionalTaxRate)
        }
        
    }

    func parseLocaleJSON(jsonData:JSONValue) {
        
        for resource in jsonData["array"].array! {
            var localeName = resource["name"].string!
            var newTax:Double? = resource["additionalTaxRate"].number
            var newTip:Double? = resource["tipRate"].number
            var newCountryName = resource["country"].string!
            updateLocales(localeName, additionalTaxRate: newTax, tipRate: newTip, country: localeListSingleton.getCountry(newCountryName))
        }
       }

    func updateLocales(localeName: String, additionalTaxRate: Double?, tipRate: Double?, country: Country) {
        
        for(var i=0;i < localeListSingleton.localeList.count; i++)
        {
            if(localeListSingleton.localeList[i].name == localeName)
            {
                localeListSingleton.localeList[i].tipRate = tipRate
                localeListSingleton.localeList[i].additionalTaxRate = additionalTaxRate
                localeListSingleton.localeList[i].country = country
            }
        }
    }
}