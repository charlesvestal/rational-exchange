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
    var delegate:CVCountrySummaryViewController?
    
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
        
        if (!placemark.description.isEmpty) {
            locationManager.stopUpdatingLocation()
            
            var locality = placemark.locality
            
            var currentLocale:Locale
            var stateName:String? =  exchangeCalc.localeList.states[placemark.administrativeArea]
            
            var state = placemark.administrativeArea
            var country = placemark.country

            
            println(locality)
            println(state)
            println(country)
            var newLocale:Locale = localeListSingleton.getLocale("Oregon")
            
            if (localeDomain == "home"){
                // change to searchLocaleTree and move somewher else
                if ((locality != nil) && (exchangeCalc.localeList.getLocale(locality).name != "Choose a Locale")) {
                    newLocale = exchangeCalc.localeList.getLocale(locality)
                    exchangeCalc.updateLocale(newLocale.name, isForeign: false)             }
                else if ((state != nil) && (exchangeCalc.localeList.getLocale(state).name != "Choose a Locale")) {
                    newLocale = localeListSingleton.getLocale(state)
                      exchangeCalc.updateLocale(newLocale.name, isForeign: false)
                }
                else if ((state != nil) && (stateName != nil) && (exchangeCalc.localeList.getLocale(stateName!).name != "Choose a Locale")) {
                    
                    newLocale = exchangeCalc.localeList.getLocale(stateName!)
                      exchangeCalc.updateLocale(newLocale.name, isForeign: false)
                    
                }else if ((country != nil) && (exchangeCalc.localeList.getLocale(country).name != "Choose a Locale")) {
                    newLocale = exchangeCalc.localeList.getLocale(country)
                      exchangeCalc.updateLocale(newLocale.name, isForeign: false)
                    
                } else {
                    println("we didn't find anything")
                    println(locality)
                    println(state)
                    println(country)
                }
            } else if
            (localeDomain == "foreign"){
                if ((locality != nil) && (exchangeCalc.localeList.getLocale(locality).name != "Choose a Locale")) {
                    newLocale = exchangeCalc.localeList.getLocale(locality)
                      exchangeCalc.updateLocale(newLocale.name, isForeign: true)
                }
                else if ((state != nil) && (exchangeCalc.localeList.getLocale(state).name != "Choose a Locale")) {
                    newLocale = exchangeCalc.localeList.getLocale(state)
                   exchangeCalc.updateLocale(newLocale.name, isForeign: true)
                }
                else if ((state != nil) && (stateName != nil) && (exchangeCalc.localeList.getLocale(stateName!).name != "Choose a Locale")) {
                    newLocale = exchangeCalc.localeList.getLocale(stateName!)
                    exchangeCalc.updateLocale(newLocale.name, isForeign: true)
                    
                }else if ((country != nil) && (exchangeCalc.localeList.getLocale(country).name != "Choose a Locale")) {
                    newLocale = exchangeCalc.localeList.getLocale(country)
                    exchangeCalc.updateLocale(newLocale.name, isForeign: true)
                    
                } else {
                    println("we didn't find anything")
                    println(locality)
                    println(state)
                    println(country)
                }
            }
            println("update the ui now")
            
            delegate?.setupFlag(newLocale)
            delegate?.setupLabels(newLocale)
            delegate?.showAllTheLabels()
           
            NSNotificationCenter.defaultCenter().postNotificationName(mySpecialNotificationKey, object: self)
            
           
        }
    }

    
}
