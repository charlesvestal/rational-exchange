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
   //     println("init")
    }

    let locationManager = CLLocationManager()

    init(domain: String) {
        setDomainer = domain
  //      println("init with string")
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

            if (localeDomain == "home"){
                // change to searchLocaleTree and move somewher else
                if ((locality != nil) && (localeListSingleton.getLocale(locality).name != "Choose a Location")) {
                    exchangeCalc.homeLocale = localeListSingleton.getLocale(locality)
                }
                else if ((state != nil) && (localeListSingleton.getLocale(state).name != "Choose a Location")) {
                    exchangeCalc.homeLocale = localeListSingleton.getLocale(state)
                }
                else if ((state != nil) && (stateName != nil) && (localeListSingleton.getLocale(stateName!).name != "Choose a Location")) {
                    exchangeCalc.homeLocale = localeListSingleton.getLocale(stateName!)
                    
                }else if ((country != nil) && (localeListSingleton.getLocale(country).name != "Choose a Location")) {
                    exchangeCalc.homeLocale = localeListSingleton.getLocale(country)
                    
                } else {
                    println("we didn't find anything")
                    println(locality)
                    println(state)
                    println(country)
                }
            } else if
            (localeDomain == "foreign"){
                if ((locality != nil) && (localeListSingleton.getLocale(locality).name != "Choose a Location")) {
                    exchangeCalc.foreignLocale = localeListSingleton.getLocale(locality)
                }
                else if ((state != nil) && (localeListSingleton.getLocale(state).name != "Choose a Location")) {
                    exchangeCalc.foreignLocale = localeListSingleton.getLocale(state)
                }
                else if ((state != nil) && (stateName != nil) && (localeListSingleton.getLocale(stateName!).name != "Choose a Location")) {
                    exchangeCalc.foreignLocale = localeListSingleton.getLocale(stateName!)
                    
                }else if ((country != nil) && (localeListSingleton.getLocale(country).name != "Choose a Location")) {
                    exchangeCalc.foreignLocale = localeListSingleton.getLocale(country)
                    
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
