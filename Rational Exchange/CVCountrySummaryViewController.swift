//
//  CVCountrySummaryViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 10/8/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation
import MessageUI
import CoreLocation

class CVCountrySummaryViewController:UIViewController, MFMailComposeViewControllerDelegate, CountrySelectedDelegate {
 
    @IBOutlet weak var countryFlag: UIImageView!
    
    @IBOutlet weak var notRightButtonButton: UIButton!
    @IBOutlet weak var findMeButton: UIButton!
    @IBOutlet weak var localeName: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var taxString: UILabel!
    @IBOutlet weak var tipString: UILabel!
    
    var MyCLController = locationHelper(domain: "home")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func findMe(sender: AnyObject) {
        let containerView = self.view.superview as CVUIContainerView
       
        if(containerView.isForeign == true){
             MyCLController.setDomain("foreign")
            }else {
             MyCLController.setDomain("home")
            }
        MyCLController.setupLocationManager()
        MyCLController.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(false)
       
        var locale:Locale
        let containerView = self.view.superview as CVUIContainerView
        
        if(containerView.isForeign == true){
                locale = exchangeCalc.foreignLocale
        }else{
                locale = exchangeCalc.homeLocale
        }
        
        setupFlag(locale)
        setupLabels(locale)
        
    }
    
    func UserDidSelectLocale(selectedLocale:Locale, isForeign:Bool)
    {
        setupFlag(selectedLocale)
        setupLabels(selectedLocale)
    }
    
    func setupFlag (locale:Locale) {
        countryFlag.image = UIImage(named:locale.country.ISOAbbreviation)
        countryFlag.image = countryFlag.image?.applyDarkEffect()
        countryFlag.parallaxIntensity = -50
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedTableView" {
        let secondVC:CountryTableViewController = segue.destinationViewController as CountryTableViewController
            secondVC.delegate = self
        }
    }
    
    func setupLabels(locale:Locale) {
        localeName.text = locale.name.uppercaseString
        currencyName.text = String(format:"%@ (%@)", locale.country.currencyName, locale.country.currencyCode)
        
        if(locale.additionalTaxRate == 0){
            taxString.text = "Nothing! Tax is included."
        }
        else if(locale.additionalTaxRate == nil) {
            taxString.text = "Usually tax is included, but you should check."
        }
        else {
            taxString.text = String(format: "%.2f%% in Sales Tax", locale.additionalTaxRate! * 100)
        }
        
        if (locale.tipRate == 0.0){
            tipString.text = "Tipping isn't the custom here."
        }
        else if(locale.tipRate == nil) {
            tipString.text = "We're not sure. Usually you should round up."
        }
        else {
            tipString.text = String(format: "%.2f%% for Gratiuity", locale.tipRate! * 100)
        }
    }
   
    @IBAction func notRightButton(sender: AnyObject) {
        
        var emailTitle = String(format:"Updating You on RationalEx - Location of %@", self.localeName.text!)

        var messageBody1 = String(format:"<p>I noticed your information for %@ is incorrect.</p> <p>There should actually this much tax added to prices: </p> <p>And tipping should be:</p>", self.localeName.text!)
       
        var messageBody2 = String(format:"</br></br></br></br></br></br>Debug info: name: %@, tax: %@, tip: %@", self.localeName.text!, self.taxString.text!, self.tipString.text!)
        var messageBody = messageBody1 + messageBody2
        var toRecipents = ["charlesv@gmail.com"]
        
        var mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: true)
        mc.setToRecipients(toRecipents)
        
        self.presentViewController(mc, animated: true, completion: nil)
    }
    
    func hideThings(){
     println("hide")
        notRightButtonButton.hidden = true

    }
    
    func showThings(){
        println("show")
        notRightButtonButton.hidden = false

    }
    func enableThings(){
        println("enable")
                self.findMeButton.enabled = true
                self.notRightButtonButton.enabled = true
    }
    
    func disableThings(){
        println("disable")
                self.findMeButton.enabled = false
                self.notRightButtonButton.enabled = false
    }
    
}