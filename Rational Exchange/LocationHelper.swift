//
//  LocationHelper.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/22/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//


import UIKit
import CoreLocation

class locationHelper:NSObject, CLLocationManagerDelegate {

    var setDomainer:String = ""
    var delegate:ViewController?
    
    override init(){
        println("init")
    }

    let locationManager = CLLocationManager()

    init(domain: String) {
        setDomainer = domain
        println("init with string")
    }
    
    func setDomain(domain:String) {
        setDomainer = domain
        }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.updateLocationInfo(pm, localeDomain:self.setDomainer)
                println("updating location")
                println(self.setDomainer)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func updateLocationInfo(placemark: CLPlacemark, localeDomain:String) {
        
        if placemark.description != nil {
            locationManager.stopUpdatingLocation()
            
            
            
            var locality = placemark.locality
            
            var currentLocale:Locale
            var stateName:String? = localeListSingleton.states[placemark.administrativeArea]
            
            var state = placemark.administrativeArea
            var country = placemark.country
            println("localeDomain")
            println(localeDomain)
            
            if (localeDomain == "home"){
                if ((locality != nil) && (localeListSingleton.getLocale(locality).name != "Choose a Location")) {
                    println("we found a locale!")
                    println(locality)
                    
                    exchangeCalc.homeLocale = localeListSingleton.getLocale(locality)
                    println(exchangeCalc.homeLocale.name)
                }
                else if ((state != nil) && (localeListSingleton.getLocale(state).name != "Choose a Location")) {
                    println("we found a state!")
                    println(state)
                    exchangeCalc.homeLocale = localeListSingleton.getLocale(state)
                    println(exchangeCalc.homeLocale.name)
                }
                else if ((state != nil) && (stateName != nil) && (localeListSingleton.getLocale(stateName!).name != "Choose a Location")) {
                    println("we found a stateName!")
                    println(stateName)
                    exchangeCalc.homeLocale = localeListSingleton.getLocale(stateName!)
                    println(exchangeCalc.homeLocale.name)
                    
                }else if ((country != nil) && (localeListSingleton.getLocale(country).name != "Choose a Location")) {
                    println("we found a country!")
                    println(country)
                    exchangeCalc.homeLocale = localeListSingleton.getLocale(country)
                    println(exchangeCalc.homeLocale.name)
                    
                } else {
                    println("we didn't find anything")
                    println(locality)
               
                    println(state)
                    println(country)
                }
            } else if
            (localeDomain == "foreign"){
                if ((locality != nil) && (localeListSingleton.getLocale(locality).name != "Choose a Location")) {
                    println("we found a locale!")
                    println(locality)
                    exchangeCalc.foreignLocale = localeListSingleton.getLocale(locality)
                    println(exchangeCalc.foreignLocale.name)
                }
                else if ((state != nil) && (localeListSingleton.getLocale(state).name != "Choose a Location")) {
                    println("we found a state!")
                    println(state)
                    exchangeCalc.foreignLocale = localeListSingleton.getLocale(state)
                    println(exchangeCalc.foreignLocale.name)
                }
                else if ((state != nil) && (stateName != nil) && (localeListSingleton.getLocale(stateName!).name != "Choose a Location")) {
                    println("we found a stateName!")
                    println(stateName)
                    exchangeCalc.foreignLocale = localeListSingleton.getLocale(stateName!)
                    println(exchangeCalc.foreignLocale.name)
                    
                }else if ((country != nil) && (localeListSingleton.getLocale(country).name != "Choose a Location")) {
                    println("we found a country!")
                    println(country)
                    exchangeCalc.foreignLocale = localeListSingleton.getLocale(country)
                    println(exchangeCalc.foreignLocale.name)
                    
                } else {
                    println("we didn't find anything")
                    println(locality)
                    println(state)
                    println(country)
                }
            }
            println("update the ui now")
            delegate?.updateUI()
           
        }
    }

    
}
