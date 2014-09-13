//
//  TranslatorHelper.swift
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/08/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

import Foundation

class TranslatorHelper {
    
    func translateCountriesFromJSON(data: AnyObject?) -> [Country]? {
        if let unwrappedData = data as? NSData {
            let json = JSONValue(unwrappedData)
            if let jsonCountries = json["list"].array {
                var countryList = countryListSingleton.list
                for jsonCountry in jsonCountries {
                   
                    let name = jsonCountry["name"].string!
                    let taxRate = jsonCountry["main"]["temp"].double!
                    let tipRate = jsonCountry["main"]["pressure"].double!
                    let precision = jsonCountry["main"]["humidity"].double!
                    let exchangeRate = jsonCountry["main"]["humidity"].double!
                    let currencyShort = jsonCountry["main"]["humidity"].string!
                    
                    let country = Country(name: name, taxRate: taxRate, tipRate: tipRate, exchangeRate: exchangeRate, precision: precision, currencyShort: currencyShort)
                    
                
                    countryList.append(country)
                    
                }
                return countryList
            }
        }
        return nil
    }
    
}