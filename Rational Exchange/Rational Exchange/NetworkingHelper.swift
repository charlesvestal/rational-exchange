//
//  NetworkingHelper.swift
//  WeatherApp
//
//  Created by Renzo Crisostomo on 12/08/14.
//  Copyright (c) 2014 Renzo Crisóstomo. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingHelper {
    
    let URL = "http://api.openweathermap.org/data/2.5/find"
    let translatorHelper = TranslatorHelper()
    
    func citiesWithUserLatitude(userLatitude: Double, userLongitude: Double, callback: ([Country]?, NSError?)->()) {
        let params = ["": ""]
        Alamofire.request(Alamofire.Method.GET, URL, parameters: params, encoding: Alamofire.ParameterEncoding.URL).response { (request, response, data, error) -> Void in
            let cities = self.translatorHelper.translateCountriesFromJSON(data)
            callback(cities, error)
        }
    }
    
}