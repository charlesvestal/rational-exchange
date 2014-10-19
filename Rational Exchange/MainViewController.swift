//
//  ViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI

class MainViewController: UIViewController, UISearchBarDelegate, MFMailComposeViewControllerDelegate {

    let currentVersion:NSString = UIDevice.currentDevice().systemVersion
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var foreignCurrencySymbolLabel: UILabel!
    
    @IBOutlet weak var topFrameLocaleName: UILabel!
    @IBOutlet weak var topFrameCurrencyName: UILabel!
    @IBOutlet weak var topFrameTaxString: UILabel!
    @IBOutlet weak var topFrameTipString: UILabel!
    
    @IBOutlet weak var middlePage: UIView!
    @IBOutlet weak var foreignCostField: UITextField!
    @IBOutlet weak var homeCostField: UILabel!
    @IBOutlet weak var homeCostLabel: UILabel!
    @IBOutlet weak var tipSwitch: UISwitch!
    
    

    @IBOutlet weak var bottomFrameLocaleName: UILabel!
  
    @IBOutlet weak var bottomFrameCurrencyName: UILabel!
    @IBOutlet weak var bottomFrameTaxString: UILabel!
    @IBOutlet weak var bottomFrameTipString: UILabel!
    
    @IBOutlet weak var notRightForeignButton: UIButton!
    @IBOutlet weak var notRightHomeButton: UIButton!
    @IBOutlet weak var findMeForeignButton: UIButton!
    @IBOutlet weak var findMeHomeButton: UIButton!
    
    @IBOutlet weak var activityMonitor: UIActivityIndicatorView!
    
    @IBOutlet weak var topTopLayout: NSLayoutConstraint!

    var MyCLController = locationHelper(domain: "home")
    
//    @IBAction func findMeHome(sender: AnyObject) {
//        MyCLController.setDomain("home")
//        MyCLController.setupLocationManager()
//        MyCLController.delegate = self
//        }
//
//    @IBAction func findMeForeign(sender: AnyObject) {
//        MyCLController.setDomain("foreign")
//        MyCLController.setupLocationManager()
//        MyCLController.delegate = self
//    }

    
    @IBAction func notRightForeignButtonPressed(sender: AnyObject) {
        var emailTitle = String(format:"Updating You on RationalEx - Foreign Location of %@", exchangeCalc.foreignLocale.name)
        var messageBody1 = String(format:"<p>I noticed your information for %@ is incorrect.</p> <p>There should actually this much tax added to prices: </p> <p>And tipping should be:</p>", exchangeCalc.foreignLocale.name)
        
        var messageBody2 = String(format:"</br></br></br></br></br></br>Debug info: name: %@, tax: %@, tip: %@", exchangeCalc.foreignLocale.name, topFrameTaxString.text!, topFrameTipString.text!)
        
        var messageBody = messageBody1 + messageBody2
        var toRecipents = ["charlesv@gmail.com"]
        var mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: true)
        mc.setToRecipients(toRecipents)
        
        self.presentViewController(mc, animated: true, completion: nil)
    }
    
    
    @IBAction func notRightHomeButtonPressed(sender: AnyObject) {
        var emailTitle = String(format:"Updating You on RationalEx - Home Location of %@", exchangeCalc.homeLocale.name)
        var messageBody1 = String(format:"<p>I noticed your information for %@ is incorrect.</p> <p>There should actually this much tax added to prices: </p> <p>And tipping should be:</p>", exchangeCalc.homeLocale.name)
        
        var messageBody2 = String(format:"</br></br></br></br></br></br>Debug info: name: %@, tax: %@, tip: %@", exchangeCalc.homeLocale.name, bottomFrameTaxString.text!, bottomFrameTipString.text!)
        
        var messageBody = messageBody1 + messageBody2
        var toRecipents = ["charlesv@gmail.com"]
        var mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: true)
        mc.setToRecipients(toRecipents)
        
        self.presentViewController(mc, animated: true, completion: nil)
    }
    
    
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError) {
        switch result.value {
        case MFMailComposeResultCancelled.value:
            NSLog("Mail cancelled")
        case MFMailComposeResultSaved.value:
            NSLog("Mail saved")
        case MFMailComposeResultSent.value:
            NSLog("Mail sent")
        case MFMailComposeResultFailed.value:
            NSLog("Mail sent failure: %@", [error.localizedDescription])
        default:
            break
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    

    func setDefaults() {
        defaults.setObject(exchangeCalc.homeLocale.name, forKey: "homeLocaleName")
        defaults.setObject(exchangeCalc.foreignLocale.name, forKey: "foreignLocaleName")
        defaults.setObject(foreignCostField.text, forKey: "foreignCostField")
        defaults.setBool(tipSwitch.on, forKey: "tipSwitch")
        println("set defaults")
        defaults.synchronize()
    }
    
    func readDefaults()
    {
        if let homeLocaleisNotNil = defaults.objectForKey("homeLocaleName") as? String {
            exchangeCalc.homeLocale = exchangeCalc.localeList.getLocale(defaults.objectForKey("homeLocaleName") as String)
        }
  
        if let foreignLocaleisNotNil = defaults.objectForKey("foreignLocaleName") as? String {
            exchangeCalc.foreignLocale = exchangeCalc.localeList.getLocale(defaults.objectForKey("foreignLocaleName") as String)
        }
        
        if let foreignCostisNotNil = defaults.objectForKey("foreignCostField") as? String {
            foreignCostField.text = defaults.objectForKey("foreignCostField") as String
        }
        
        if let tipSwitchIsNotNil = defaults.objectForKey("tipSwitch") as? Bool {
            tipSwitch.on = defaults.objectForKey("tipSwitch") as Bool
        }
    }
    
    @IBOutlet weak var topItLooksLike: UILabel!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var gotoTopButtonButton: UIButton!

    @IBOutlet weak var gotoBottomButtonButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let now = NSDate()
        readDefaults()
        parseInit()
        
        self.navigationController?.navigationBarHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        
        
        gotoTopButtonButton.layer.cornerRadius = 0.5 * gotoTopButtonButton.bounds.size.width
        gotoTopButtonButton.layer.masksToBounds = true
        
        gotoBottomButtonButton.layer.cornerRadius = 0.5 * gotoBottomButtonButton.bounds.size.width
        gotoBottomButtonButton.layer.masksToBounds = true

        
        
//        initUI()
        setupScrollView()
//        updateUI()
        
        
        
        var delegate:locationHelper?
        
         }
    
    func setupScrollView ()
    {
        var numberOfPages:CGFloat = CGFloat(scrollView.subviews.count) - 1
        
        scrollView.contentSize = CGSize(width: mainView.bounds.width, height: (mainView.bounds.height * (numberOfPages - 1)))
       
        let startingPage:CGFloat = 1
            scrollView.contentOffset = CGPointMake(0,(mainView.bounds.height * startingPage))
    }
    
    
    @IBAction func gotoButtomButton(sender: AnyObject) {
        
        let pageNumber:CGFloat = 2
        var thirdPageStart =
        CGPointMake(0,(mainView.bounds.height * pageNumber))
        
        scrollView.setContentOffset(thirdPageStart, animated: true)
    }
    
    @IBAction func gotoTopButton(sender: AnyObject) {
        scrollView.setContentOffset(CGPointMake(0,0), animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        if (currentVersion.doubleValue < 8.0)
        {
            setupScrollView()
        }
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
            self.view.endEditing(true)
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fieldChanged(sender : AnyObject) {
//         updateCenterScreen()
         defaults.setBool(tipSwitch.on, forKey: "tipSwitch")
         defaults.synchronize()
    }
    


//   func initUI()
//   {
//        let keyboardDoneButtonView:UIToolbar = UIToolbar()
//            keyboardDoneButtonView.sizeToFit()
//        
//        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "Done",
//            style: .Done,
//            target: self,
//            action: "doneClicked")
//        
//        keyboardDoneButtonView.setItems([doneButton], animated:false)
//    
//        foreignCostField.inputAccessoryView = keyboardDoneButtonView
//    
//    
//        exchangeCalc.localeList.refreshCountries()
//    }
    
    
//    func updateCenterScreen(){
//       
//        exchangeCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
//        
//        var homeFormatter = NSNumberFormatter()
//        homeFormatter.numberStyle = .CurrencyStyle
//        homeFormatter.currencyCode = exchangeCalc.homeLocale.country.currencyCode
//        
//        var foreignFormatter = NSNumberFormatter()
//        foreignFormatter.numberStyle = .CurrencyStyle
//        foreignFormatter.currencyCode = exchangeCalc.foreignLocale.country.currencyCode
//
//        var tippable = isTippable()
//        
//        var homeShouldFeelLikeFormated = homeFormatter.stringFromNumber(exchangeCalc.calcShouldFeelLikeRounded(tippable))
//        
//        var homeTotalAmount = homeFormatter.stringFromNumber(exchangeCalc.calcTotalAmount(tippable))
//        
//        var foreignShouldFeelLikeFormatted = foreignFormatter.stringFromNumber(exchangeCalc.calcTotalAmountForeign(tippable))
//        
//        var homeShouldTaxLikeFormatted = homeFormatter.stringFromNumber(exchangeCalc.calcShouldTaxLike(tippable))
//        
//        
//        homeCostField.text = homeShouldFeelLikeFormated
//            
//        
//    
//        if(foreignCostField.text != "") {
//            homeFormatter.currencyCode = exchangeCalc.homeLocale.country.currencyCode
//            foreignFormatter.currencyCode = exchangeCalc.foreignLocale.country.currencyCode
//            
//            var andString:String = ""
//            var backHomeString:String = ""
//            var homeCostTipString = ""
//            var homeCostTaxString = ""
//            
//            var homeTotalString = ""
//            let tippable = isTippable()
//            
//            var foreignTax = ""
//            var foreignTip = ""
//            var totalCostString = ""
//            
//            if(exchangeCalc.calcForeignTax()! == 0){
//                foreignTax = "no"
//            }
//            else {
//                foreignTax = foreignFormatter.stringFromNumber(exchangeCalc.calcForeignTax()!)!
//            }
//            
//            
//            if(exchangeCalc.calcForeignTip(tippable) == 0){
//                foreignTip = "no"
//            }
//            else {
//                foreignTip = foreignFormatter.stringFromNumber(exchangeCalc.calcForeignTip(tippable))!
//            }
//            
//            
//            
//            var startString = String(format:"With %@ tax and %@ tip, y", foreignTax, foreignTip)
//            
//            if (foreignShouldFeelLikeFormatted! != homeTotalAmount){
//                   totalCostString = String(format:"our total is going to be %@, or %@", foreignShouldFeelLikeFormatted!, homeTotalAmount!)
//            }else {
//                 totalCostString = String(format:"our total is going to be %@", foreignShouldFeelLikeFormatted!)
//            }
//          
//            
//            if(exchangeCalc.homeLocale.tipRate != 0) || (exchangeCalc.homeLocale.additionalTaxRate != 0) {
//                backHomeString = String(format:".\n\nBack home in %@, you'd see a price of %@", exchangeCalc.homeLocale.name, homeFormatter.stringFromNumber(exchangeCalc.calcShouldFeelLike(tippable))!)
//            }
//            
//            if(exchangeCalc.calcShouldTaxLike(tippable) != 0){
//                homeCostTaxString = String(format:" plus %@ tax", homeShouldTaxLikeFormatted!)
//            }
//            
//            
//            if(exchangeCalc.calcShouldTaxLike(tippable) != 0) && (exchangeCalc.calcShouldTipLike(tippable) != 0) {
//                andString = " and "
//            }
//            
//            if (exchangeCalc.calcShouldTipLike(tippable) != 0){
//                homeCostTipString = String(format:" add %@ tip", homeFormatter.stringFromNumber(exchangeCalc.calcShouldTipLike(tippable))!)
//            }
//            
//            if(exchangeCalc.calcShouldTaxLike(tippable) != 0) || (exchangeCalc.calcShouldTipLike(tippable) != 0) {
//                 homeTotalString = String(format:", for the same total cost of %@.", homeFormatter.stringFromNumber(exchangeCalc.calcTotalAmount(tippable))!)
//            } else {
//                    homeTotalString = "."
//            }
//            
//            var totalString:String = startString + totalCostString + backHomeString + homeCostTaxString + andString + homeCostTipString + homeTotalString
//            
//            
//            homeCostLabel.text = totalString
//        }
//    }
//    
//
//    
//    func isTippable() -> Double {
//        var isTippable:Double
//        if tipSwitch.on
//        { isTippable = 1.0}
//        else
//        { isTippable = 0.0}
//
//        return isTippable
//        
//    }
    
//    func updateUI()   {
//        var tippable = isTippable()
//        
//        var homeFormatter = NSNumberFormatter()
//        homeFormatter.numberStyle = .CurrencyStyle
//        homeFormatter.currencyCode = exchangeCalc.homeLocale.country.currencyCode
//
//        var foreignFormatter = NSNumberFormatter()
//        foreignFormatter.numberStyle = .CurrencyStyle
//        foreignFormatter.currencyCode = exchangeCalc.foreignLocale.country.currencyCode
//
//
//        var foreignCurrencySymbol:String = foreignFormatter.stringFromNumber(100)!
//        var nonNumberCharacterSet = NSMutableCharacterSet.decimalDigitCharacterSet()
//            //nonNumberCharacterSet.invert()
//        foreignCurrencySymbol = foreignCurrencySymbol.componentsSeparatedByCharactersInSet(nonNumberCharacterSet)[0]
        
        
//        foreignCurrencySymbolLabel.text = foreignCurrencySymbol
//        
//        exchangeCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
//        
//        exchangeCalc.calcExchangeRate()

//        // set up foreign labels
//        topFrameLocaleName.text = exchangeCalc.foreignLocale.name.uppercaseString
//        topFrameCurrencyName.text = String(format:"%@ (%@)", exchangeCalc.foreignLocale.country.currencyName, exchangeCalc.foreignLocale.country.currencyCode)
//      
//            if(exchangeCalc.foreignLocale.additionalTaxRate == 0){
//                topFrameTaxString.text = "Nothing! Tax is included."
//            }
//            else if(exchangeCalc.foreignLocale.additionalTaxRate == nil) {
//                topFrameTaxString.text = "Usually tax is included, but you should check."
//            }
//            else {
//                topFrameTaxString.text = String(format: "%.2f%% in Sales Tax", exchangeCalc.foreignLocale.additionalTaxRate! * 100)
//            }
//
//            if (exchangeCalc.foreignLocale.tipRate == 0.0){
//                topFrameTipString.text = "Tipping isn't the custom here."
//            }
//            else if(exchangeCalc.foreignLocale.tipRate == nil) {
//                topFrameTipString.text = "We're not sure. Usually you should round up."
//            }
//            else {
//                topFrameTipString.text = String(format: "%.2f%% for Gratiuity", exchangeCalc.foreignLocale.tipRate! * 100)
//            }
//        
//        
//        // set up home labels
//        bottomFrameLocaleName.text = exchangeCalc.homeLocale.name.uppercaseString
//        bottomFrameCurrencyName.text = String(format:"%@ (%@)", exchangeCalc.homeLocale.country.currencyName, exchangeCalc.homeLocale.country.currencyCode)
//        
//        if (exchangeCalc.homeLocale.additionalTaxRate == 0.0){
//            bottomFrameTaxString.text = "Nothing! Your prices include tax."
//        }
//        else if(exchangeCalc.homeLocale.additionalTaxRate == nil) {
//            if(exchangeCalc.homeLocale.country.taxString == nil){
//                bottomFrameTaxString.text = "We think tax is normally included for you."
//            }
//            else {
//                bottomFrameTaxString.text = exchangeCalc.homeLocale.country.taxString
//            }
//        }
//        else {
//            bottomFrameTaxString.text = String(format: "%.2f%% in Sales Tax", exchangeCalc.homeLocale.additionalTaxRate! * 100)
//        }
//        
//        if (exchangeCalc.homeLocale.tipRate == 0.0){
//            bottomFrameTipString.text = "Tipping isn't the custom here."
//        }
//        else if(exchangeCalc.homeLocale.tipRate == nil) {
//            if(exchangeCalc.homeLocale.country.tipString == nil){
//                bottomFrameTipString.text = "We're not sure. Usually you should round up."
//            }
//            else {
//                bottomFrameTipString.text = exchangeCalc.homeLocale.country.tipString
//            }
//        }
//        else {
//            bottomFrameTipString.text = String(format: "%.2f%% for Gratiuity", exchangeCalc.homeLocale.tipRate! * 100)
//        }
//        
//        var homeFlag = UIImage(named:exchangeCalc.homeLocale.country.ISOAbbreviation)
//        var foreignFlag = UIImage(named:exchangeCalc.foreignLocale.country.ISOAbbreviation)
//        
//       updateCenterScreen()
//    }
//
//    
//    func refreshCountries () {
//        let currentForeignName = exchangeCalc.foreignLocale.name
//        let currentHomeName = exchangeCalc.homeLocale.name
//        exchangeCalc.updateLocale(currentForeignName, isForeign:true)
//        exchangeCalc.updateLocale(currentHomeName, isForeign:false)
//
//    }
    
    
    func parseInit() {
       
        var hud =  MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Loading"
        hud.detailsLabelText = "Updating Exchange Rates\n and Data"
        hud.dimBackground = true
        hud.hide(true, afterDelay:6.0)
        
       
        let config = PFConfig.currentConfig()
                if let localeInfo = config["localeInfo"] as? PFFile {
                println("Loading from defaults. Processing config.")
                let jsonData = JSONValue(localeInfo.getData())
                self.parseLocaleJSON(jsonData)
                self.readDefaults()
                println("Finished processing config from defaults.")
            }
        
            PFConfig.getConfigInBackgroundWithBlock {
            (var config: PFConfig!, error) -> Void in
            if (error == nil) {
                if let localeInfo = config["localeInfo"] as? PFFile {
                    println("Fetch successful. Processing config.")
                    let jsonData = JSONValue(localeInfo.getData())
                    self.parseLocaleJSON(jsonData)
                    self.readDefaults()
                    println("Finished processing config.")
                }
//                self.refreshCountries()
//                self.updateUI()
                hud.hide(true)
            } else {
                hud.hide(true)
                println("Failed to fetch. Using Cached Config.")
                config = PFConfig.currentConfig()
//                self.refreshCountries()
//                self.updateUI()
                self.readDefaults()
                }
                
        }
    
    }
    
    func parseLocaleJSON(jsonData:JSONValue) {
    
        exchangeCalc.localeList.localeList = [Locale]()
        
        var resources = jsonData["array"].array!
      
        
        for resource in resources {
            let localeName = resource["name"].string
            var newTax:Double?
            var newTip:Double?
            
                 newTax = resource["additionalTaxRate"].number as? Double
                 newTip = resource["tipRate"].number as? Double
            
            
            let newCountryName = resource["country"].string
            
            exchangeCalc.localeList.localeList.append(Locale(name: localeName, additionalTaxRate: newTax, tipRate: newTip, country: exchangeCalc.localeList.getCountry(newCountryName)))
            }
   
    }
    
    func updateLocales(localeName: String, additionalTaxRate: Double?, tipRate: Double?, country: Country) {
        
        for(var i=0;i < localeListSingleton.localeList.count; i++)
        {
            if(localeListSingleton.localeList[i].name == localeName)
            {
                localeListSingleton.localeList[i].tipRate = tipRate
                localeListSingleton.localeList[i].additionalTaxRate = additionalTaxRate
                localeListSingleton.localeList[i].country = country
            }
        }
    }
    

}

