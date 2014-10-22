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
    
    @IBOutlet weak var locationLabel: UILabel!
    

    var MyCLController = locationHelper(domain: "home")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    func setColors(locale: Locale) {
        var image = UIImage(named:locale.country.ISOAbbreviation)
        image = image?.scaledToSize(view.frame.size)
        var colorArt:SLColorArt = image!.colorArt()
        self.localeName.textColor = colorArt.primaryColor
        self.currencyName.textColor = colorArt.secondaryColor
        self.locationLabel.textColor = colorArt.detailColor
        self.taxString.textColor = colorArt.backgroundColor
        
//        self.fadedImageView.backgroundColor = colorArt.backgroundColor;
//        self.fadedImageView.image = image;
//        self.view.backgroundColor = colorArt.backgroundColor;
//        self.headline.textColor = colorArt.primaryColor;
//        self.subHeadline.textColor = colorArt.secondaryColor;
//        self.text.textColor = colorArt.detailColor;

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
                locationLabel.text = "YOU ARE VISITING"

        }else{
                locale = exchangeCalc.homeLocale
                locationLabel.text = "YOU ARE FROM"
        }
        
        setupFlag(locale)
        setupLabels(locale)
        setColors(locale)
        
    }
    
    func UserDidSelectLocale(selectedLocale:Locale, isForeign:Bool)
    {
        setupFlag(selectedLocale)
        setupLabels(selectedLocale)
        setColors(selectedLocale)
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