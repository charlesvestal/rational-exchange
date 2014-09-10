//
//  CountryListModel.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/7/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

var countryListSingleton = CountryList()

class CountryList {
    
    init() {
        println("you initialized a CountryList")
    }
    
    var list:[Country] = [
        Country(name:"None", taxRate: 0.0, tipRate: 0.0, exchangeRate: 21.31, precision: 1, currencyShort:"CZK"),
        Country(name:"Prague", taxRate: 0.0, tipRate: 0.0, exchangeRate: 21.31, precision: 1, currencyShort:"CZK"),
        Country(name:"USA", taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyShort:"USD"),
        Country(name:"Portland", taxRate: 0.0, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyShort:"USD"),
        Country(name:"Euro", taxRate: 0, tipRate: 0, exchangeRate: 0.76, precision: 1, currencyShort:"EUR"),
        Country(name:"Norway", taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1, currencyShort:"NOK"),
        Country(name:"Magic10", taxRate: 0.1, tipRate: 0.1, exchangeRate: 1, precision: 1, currencyShort:"M10"),
        Country(name:"Magic20", taxRate: 0.2, tipRate: 0.2, exchangeRate: 1, precision: 1, currencyShort:"M20")
    ]


    func getCountry(countryName: String) -> Country {
        var i:Int
        
        for(i=0;i<list.count; i++)
        {
            if(list[i].name == countryName){
                return list[i]
            }
        }
        return list[0] // what should we do if the country doesn't exist? theoretically it shouldn't happen since we're only choosing from the above list
    }
    
}


