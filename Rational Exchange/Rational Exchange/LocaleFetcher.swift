//
//  LocaleFetcher.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/7/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation
import Alamofire


var localeListSingleton = LocaleList()

class LocaleList {
    
    var list:[Locale]

    var defaultLocaleList = [
        Locale(name:"Prague", country:"Czech Republic", taxRate: 0.0, tipRate: 0.0, exchangeRate: 21.31, precision: 1, currencyName: "Czeck Something", currencyCode:"CZK"),
        Locale(name:"Texas", country:"USA", taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyName: "Dollar",  currencyCode:"USD"),
        Locale(name:"Oregon", country:"USA", taxRate: 0.0, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyName: "Dollar", currencyCode:"USD"),
        Locale(name:"Berlin", country:"Germany", taxRate: 0.0, tipRate: 0.0, exchangeRate: 0.76, precision: 1, currencyName:"Euro", currencyCode:"EUR"),
        Locale(name:"Oslo", country:"Norway", taxRate: 0.0, tipRate: 0.0, exchangeRate: 6.0, precision: 1, currencyName: "Norwegian Kroner", currencyCode:"NOK"),
        ]

    init() {
        list = defaultLocaleList
    }
    
    
    func refreshLocales() {
        
        let url = "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"
        
        Alamofire.request(.GET, url)
            .responseJSON { (request, response, data, error) in
                
                let jsonData = JSONValue(data!)
                
                // TODO: this will need to be rebuilt to actually look for existing locales and update the data
                
                for resource in jsonData["list"]["resources"].array!{
                    var name = resource["resource"]["fields"]["symbol"].string!
                    
                        let stringLength = countElements(name) // strip this off for the yahoo finance API
                        let substringIndex = stringLength - 2
                        name = name.substringToIndex(advance(name.startIndex, substringIndex))
                    
                    let price = resource["resource"]["fields"]["price"].double!
                    
                    self.list.append(Locale(name: name, country:name, taxRate: 0.0, tipRate: 0.0, exchangeRate: price, precision: 0.5, currencyName: name, currencyCode: name))
                }
                
                println("Updated Locales")
        }
    }


    func getLocale(localeName: String) -> Locale {
        
        for(var i=0;i<self.list.count; i++)
        {
            if(list[i].name == localeName){
                return list[i]
            }
        }
        return Locale(name: "boo", country:"soo", taxRate: 0.0, tipRate: 0.0, exchangeRate: 0.0, precision: 0.0, currencyName: "poo", currencyCode: "HEY") // what should we do if the Locale doesn't exist? theoretically it shouldn't happen since we're only choosing from the above list
    }
    
}


