//
//  CountryListModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/7/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation
import Alamofire


var countryListSingleton = CountryList()

class CountryList {

    var list:[Country]

    var defaultCountryList = [
        Country(name:"Prague", taxRate: 0.0, tipRate: 0.0, exchangeRate: 21.31, precision: 1, currencyShort:"CZK"),
        Country(name:"USA", taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyShort:"USD"),
        Country(name:"Portland", taxRate: 0.0, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyShort:"USD"),
        Country(name:"Euro", taxRate: 0, tipRate: 0, exchangeRate: 0.76, precision: 1, currencyShort:"EUR"),
        Country(name:"Norway", taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1, currencyShort:"NOK"),
        Country(name:"Magic10", taxRate: 0.1, tipRate: 0.1, exchangeRate: 1, precision: 1, currencyShort:"M10"),
        Country(name:"Magic20", taxRate: 0.2, tipRate: 0.2, exchangeRate: 1, precision: 1, currencyShort:"M20")
    ]

    init() {
        list = defaultCountryList
    }
    
    
    func refreshCountries() {
        
        let url = "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"
        
        Alamofire.request(.GET, url)
            .responseJSON { (request, response, data, error) in
                
                let jsonData = JSONValue(data!)
                
                // TODO: this will need to be rebuilt to actually look for existing countries and update the data
                
                for resource in jsonData["list"]["resources"].array!{
                    let name = resource["resource"]["fields"]["symbol"].string!
                    let price = resource["resource"]["fields"]["price"].double!
                    self.list.append(Country(name: name, taxRate: 0.0, tipRate: 0.0, exchangeRate: price, precision: 0.0, currencyShort: name))
                }
                
                println("Updated Countries")
        }
    }


    func getCountry(countryName: String) -> Country {
        
        for(var i=0;i<self.list.count; i++)
        {
            if(list[i].name == countryName){
                return list[i]
            }
        }
        return Country(name: "boo", taxRate: 0.0, tipRate: 0.0, exchangeRate: 0.0, precision: 0.0, currencyShort: "HEY") // what should we do if the country doesn't exist? theoretically it shouldn't happen since we're only choosing from the above list
    }
    
}


