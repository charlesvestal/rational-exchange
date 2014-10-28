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
 
    @IBOutlet var countryView: UIView!
    
    @IBOutlet weak var countryFlag: UIImageView!
    
    @IBOutlet weak var findMeButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var localeName: UILabel!


    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var taxString: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipString: UILabel!
    @IBOutlet weak var notRightButtonButton: UIButton!

    @IBOutlet weak var noCountryView: UIView!    
    @IBOutlet weak var noCountryLabel: UILabel!
    @IBOutlet weak var noCountryImage: UIImageView!
    
    var MyCLController = locationHelper(domain: "home")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func hideAllTheLabels() {
        countryFlag.hidden = true
        localeName.hidden = true
        currencyLabel.hidden = true
        currencyName.hidden = true
        taxLabel.hidden = true
        taxString.hidden = true
        tipLabel.hidden = true
        tipString.hidden = true
        notRightButtonButton.hidden = true
        noCountryView.hidden = false
    }
    
    func showAllTheLabels () {
        countryFlag.hidden = false
        localeName.hidden = false
        currencyLabel.hidden = false
        currencyName.hidden = false
        taxLabel.hidden = false
        taxString.hidden = false
        tipLabel.hidden = false
        tipString.hidden = false
        notRightButtonButton.hidden = false
        noCountryView.hidden = true
    }
    
    @IBAction func findMe(sender: AnyObject) {
        
        var hud =  MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.detailsLabelText = "Finding Your Location"
        hud.dimBackground = true
        hud.hide(true, afterDelay:2.0)
        
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
                locationLabel.text = "YOU ARE VISITING"
                noCountryLabel.text = "Choose Your Visiting Location"
                noCountryImage.image = UIImage(named: "awayBig")
                countryView.backgroundColor = UIColor(red: 0.204, green: 0.44, blue: 0.682, alpha: 1.0)
        }else{
                locale = exchangeCalc.homeLocale
                locationLabel.text = "YOU ARE FROM"
                noCountryLabel.text = "Choose Your Home Location"
                noCountryImage.image = UIImage(named: "homeBig")
                countryView.backgroundColor = UIColor(red: 0.359, green:0.67, blue:0.857, alpha:1.0)
        }
        
        
        if (locale.name == "init") {
            hideAllTheLabels()
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
        
        let tintColor = UIColor(white:0.2, alpha:0.5)
       
        countryFlag.image = countryFlag.image?.applyBlurWithRadius(5, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil)
        
        
        
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
        
        if (locale.country.taxString != nil) {
            taxString.text = locale.country.taxString
        } else if(locale.additionalTaxRate == 0){
            taxString.text = "Nothing! Tax is included."
        }
        else if(locale.additionalTaxRate == nil) {
            taxString.text = "Usually tax is included, but you should check."
        }
        else {
            taxString.text = String(format: "%.2f%% in Sales Tax", locale.additionalTaxRate! * 100)
        }
        
        if (locale.tipString != nil){
            tipString.text = locale.tipString
        } else if (locale.country.tipString != nil) {
            tipString.text = locale.country.tipString
        } else if (locale.tipRate == 0.0){
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
        var mc: MFMailComposeViewController = MFMailComposeViewController()
        
        var isForeign:String = ""
        let containerView = self.view.superview as CVUIContainerView
        if(containerView.isForeign == true){
            isForeign = "was visiting"
        }else {
            isForeign = "am from"
        }

        
        let emailTitle = String(format:"Updating You on RationalEx - Location of %@", self.localeName.text!)
        let messageBody1 = String(format:"<p>I %@, and noticed your information for %@ is incorrect.</p> <p>There should actually this much tax added to prices: </p> <p>And tipping should be:</p>", isForeign, self.localeName.text!)
        let messageBody2 = String(format:"</br></br></br></br></br></br>Debug info: name: %@, tax: %@, tip: %@ visiting: %@", self.localeName.text!, self.taxString.text!, self.tipString.text!, isForeign)
        let messageBody = messageBody1 + messageBody2
        let toRecipents = ["charlesv@gmail.com"]
        
        
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: true)
        mc.setToRecipients(toRecipents)

        mc.mailComposeDelegate = self

        if (MFMailComposeViewController.canSendMail() == true){
            self.presentViewController(mc, animated: true, completion: nil)
            println("we did it")
        }
        else{
            println("we didn't do it")
            // Show some error message here
        }
    }
    
    
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError) {
        switch result.value {
        case MFMailComposeResultCancelled.value:
            println("Mail cancelled")
        case MFMailComposeResultSaved.value:
            println("Mail saved")
        case MFMailComposeResultSent.value:
            println("Mail sent")
        case MFMailComposeResultFailed.value:
            println("Mail sent failure: %@", error.localizedDescription)
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    func hideThings(){
     println("hide")
        notRightButtonButton.hidden = true

    }
    
    func showThings(){
        println("show")

        var localeName:String
        let containerView = self.view.superview as CVUIContainerView
        
        if(containerView.isForeign == true){
            localeName = exchangeCalc.foreignLocale.name
        } else {
            localeName = exchangeCalc.homeLocale.name
        }
        
        if(localeName != "init") {
            self.notRightButtonButton.hidden = false
        }
    }
    
    func enableThings(){
        println("enable")
                self.findMeButton.enabled = true
        
        
        var localeName:String
        let containerView = self.view.superview as CVUIContainerView

        if(containerView.isForeign == true){
            localeName = exchangeCalc.foreignLocale.name
        } else {
            localeName = exchangeCalc.homeLocale.name
        }
        
        if(localeName != "init") {
            self.notRightButtonButton.enabled = true
        }
    }
    
    func disableThings(){
        println("disable")
                self.findMeButton.enabled = false
                self.notRightButtonButton.enabled = false
    }
    
}