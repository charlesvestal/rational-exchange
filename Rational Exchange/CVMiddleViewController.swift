//
//  CVMiddleViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 10/8/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

let scrollTopKey = "com.andrewcbancroft.specialNotificationKeyTop"
let scrollBottomKey = "com.andrewcbancroft.specialNotificationKeyBottom"


class CVMiddleViewController: UIViewController {

    @IBOutlet weak var gotoTopButton: UIButton!
    @IBOutlet weak var gotoBottomButton: UIButton!
    
    
    @IBOutlet weak var foreignCurrencySymbol: UILabel!
    @IBOutlet weak var foreignCostField: UITextField!
    
    @IBAction func fieldChanged(sender : AnyObject) {
        updateCenterScreen()
        defaults.setBool(tipSwitch.on, forKey: "tipSwitch")
        defaults.synchronize()
    }
    
    @IBOutlet weak var tipSwitch: UISwitch!
    
    @IBOutlet weak var upArrow: UIView!
    @IBOutlet weak var downArrow: UIView!
    
    @IBOutlet weak var homeCostField: UITextField!
    @IBOutlet weak var homeCostLabel: UILabel!
    
    
    
  
    override func viewDidLoad() {
        
        super.viewDidLoad()
        keyboardSetup()
        roundTheButtons()

        readDefaults()
        parseInit()
        //animateButtons()
        updateCenterScreen()
        updateFlags()

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "actOnSpecialNotification", name: mySpecialNotificationKey, object: nil)
    }
    
        override func viewDidAppear(animated: Bool) {
            
//            var oldUpOrigin = upArrow.frame.origin
//            var oldDownOrigin = downArrow.frame.origin
//            
//            animateArrows1(oldUpOrigin, oldDownOrigin: oldDownOrigin)
        }
//    
//
//    func animateArrows1(oldUpOrigin: CGPoint, oldDownOrigin: CGPoint) {
//        var upArrowFrame = self.upArrow.frame
//        var downArrowFrame = self.downArrow.frame
//        
//        UIView.animateWithDuration(2.0, delay: 0.0, options: .Repeat | .Autoreverse | .AllowUserInteraction | .CurveEaseOut, animations: {
////            
////            upArrowFrame.origin.y -= upArrowFrame.size.height
////            downArrowFrame.origin.y += downArrowFrame.size.height
//            self.upArrow.alpha = 1
//            self.downArrow.alpha = 1
////            self.upArrow.frame = upArrowFrame
////            self.downArrow.frame = downArrowFrame
//            }, completion: nil
//        )
//    }
    
//    func animateArrows2(oldUpOrigin: CGPoint, oldDownOrigin: CGPoint) {
//        
//        UIView.animateWithDuration(0.2, delay: 0.0, options: .AllowUserInteraction | .CurveEaseOut, animations: {
//            
//            self.upArrow.alpha = 0
//            self.downArrow.alpha = 0
//            
//            }, completion: { finished in
//                self.upArrow.frame.origin = oldUpOrigin
//                self.downArrow.frame.origin = oldDownOrigin
//                
//                self.animateArrows1(oldUpOrigin, oldDownOrigin: oldDownOrigin)
//                
//            }
//        )
//
//        
//        
//    }
    
    
    func actOnSpecialNotification() {
        updateCenterScreen()
        updateFlags()
        setDefaults()
    }
    
    func setDefaults() {
        defaults.setObject(exchangeCalc.homeLocale.name, forKey: "homeLocaleName")
        defaults.setObject(exchangeCalc.foreignLocale.name, forKey: "foreignLocaleName")
        defaults.setObject(foreignCostField.text, forKey: "foreignCostField")
        defaults.setBool(tipSwitch.on, forKey: "tipSwitch")
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
    
    
    @IBAction func gotoTopButton(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(scrollTopKey, object: self)

    }
    
    @IBAction func gotoButtomButton(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(scrollBottomKey, object: self)
    }
    
    

    func updateCenterScreen(){
   
        // set formatters for home and foreign currency
    
        let currentForeignName = exchangeCalc.foreignLocale.name
        let currentHomeName = exchangeCalc.homeLocale.name
        exchangeCalc.updateLocale(currentForeignName, isForeign:true)
        exchangeCalc.updateLocale(currentHomeName, isForeign:false)
        
        var homeFormatter = NSNumberFormatter()
        homeFormatter.numberStyle = .CurrencyStyle
        homeFormatter.currencyCode = exchangeCalc.homeLocale.country.currencyCode
        
        var foreignFormatter = NSNumberFormatter()
        foreignFormatter.numberStyle = .CurrencyStyle
        foreignFormatter.currencyCode = exchangeCalc.foreignLocale.country.currencyCode
        
        
        var foreignCurrencySymbolString:String = foreignFormatter.stringFromNumber(100)!
        var nonNumberCharacterSet = NSMutableCharacterSet.decimalDigitCharacterSet()
       
        foreignCurrencySymbolString = foreignCurrencySymbolString.componentsSeparatedByCharactersInSet(nonNumberCharacterSet)[0]

        foreignCurrencySymbol.text = foreignCurrencySymbolString
        
        
        
        
        
        // set the exchangeCalc singleton value to the foreign Cost lable
        exchangeCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
        
        exchangeCalc.calcExchangeRate()
    
        
        // get current tippable status
        var tippable = isTippable()
    
        // calculate what it should feel like rounded, for the easiest cognitive read of what the price tag would be back home
        var homeShouldFeelLikeFormated = homeFormatter.stringFromNumber(exchangeCalc.calcShouldFeelLikeRounded(tippable))
        
        // get the value of what the total would be back home, unrounded
        var homeTotalAmount = homeFormatter.stringFromNumber(exchangeCalc.calcTotalAmount(tippable))
        var foreignTotalAmount = foreignFormatter.stringFromNumber(exchangeCalc.calcTotalAmountForeign(tippable))
        
        var homeShouldTaxLikeFormatted = homeFormatter.stringFromNumber(exchangeCalc.calcShouldTaxLike(tippable))
        
        // set the should feels like value to the rounded amount
        
        homeCostField.text = homeShouldFeelLikeFormated
        
        
        
        if(foreignCostField.text != "") {
            homeFormatter.currencyCode = exchangeCalc.homeLocale.country.currencyCode
            foreignFormatter.currencyCode = exchangeCalc.foreignLocale.country.currencyCode
            
            var andString:String = ""
            var backHomeString:String = ""
            var homeCostTipString = ""
            var homeCostTaxString = ""
            
            var homeTotalString = ""
            
            var foreignTax = ""
            var foreignTip = ""
            var totalCostString = ""

            // set the language for tax and tip, if they exist
            if(exchangeCalc.calcForeignTax()! == 0){
                foreignTax = "no"
            }
            else {
                foreignTax = foreignFormatter.stringFromNumber(exchangeCalc.calcForeignTax()!)!
            }
            
            if(exchangeCalc.calcForeignTip(tippable) == 0){
                foreignTip = "no"
            }
            else {
                foreignTip = foreignFormatter.stringFromNumber(exchangeCalc.calcForeignTip(tippable))!
            }
            
            // creat the initial string using tax and tip info
            var startString = String(format:"In %@, with %@ tax and %@ tip, y", exchangeCalc.foreignLocale.name, foreignTax, foreignTip)

            // change the ending language, depending on if your foreign and home total amounts are identical (no need to list them twice)
            if (foreignTotalAmount! != homeTotalAmount){
                totalCostString = String(format:"our total is going to be %@, or %@",foreignTotalAmount!, homeTotalAmount!)
            }else {
                totalCostString = String(format:"our total is going to be %@", foreignTotalAmount!)
            }
            
            // only show "back home" if you're doing something else!
            if(exchangeCalc.homeLocale.tipRate != 0) || (exchangeCalc.homeLocale.additionalTaxRate != 0) {
                backHomeString = String(format:".\n\nBack home in %@, you'd see a price of %@", exchangeCalc.homeLocale.name, homeFormatter.stringFromNumber(exchangeCalc.calcShouldFeelLike(tippable))!)
            }
            
            // only show the tax string if you're adding tax
            if(exchangeCalc.calcShouldTaxLike(tippable) != 0){
                homeCostTaxString = String(format:" plus %@ tax", homeShouldTaxLikeFormatted!)
            }
            
            // include an "and" if you're adding tip AND tax
            if(exchangeCalc.calcShouldTaxLike(tippable) != 0) && (exchangeCalc.calcShouldTipLike(tippable) != 0) {
                andString = " and"
            }
            
            // only show tip string if you're adding tip
            if (exchangeCalc.calcShouldTipLike(tippable) != 0){
                homeCostTipString = String(format:" add %@ tip", homeFormatter.stringFromNumber(exchangeCalc.calcShouldTipLike(tippable))!)
            }
            
            // only show "the same total cost" if it's diferent than the actual total
            if(exchangeCalc.calcShouldTaxLike(tippable) != 0) || (exchangeCalc.calcShouldTipLike(tippable) != 0) {
                homeTotalString = String(format:", for the same total cost of %@.", homeFormatter.stringFromNumber(exchangeCalc.calcTotalAmount(tippable))!)
            } else {
            // just end the sentence, otherwise.
                homeTotalString = "."
            }
            
            var totalString:String = startString + totalCostString + backHomeString + homeCostTaxString + andString + homeCostTipString + homeTotalString
            
            
            homeCostLabel.text = totalString
        }else {
            homeCostLabel.text = "Enter an amount above in order to see what it would cost back home."
        }
        
}

    func updateFlags() {
        // update flag buttons
                var homeFlag = UIImage(named:exchangeCalc.homeLocale.country.ISOAbbreviation)
                var foreignFlag = UIImage(named:exchangeCalc.foreignLocale.country.ISOAbbreviation)
        
        let tintColor = UIColor(white:0.2, alpha:0.5)
        

        
        self.gotoTopButton.setBackgroundImage(foreignFlag?.applyBlurWithRadius(5, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil), forState: .Normal)
        self.gotoBottomButton.setBackgroundImage(homeFlag?.applyBlurWithRadius(5, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil), forState: .Normal)
        
    }
    
    func isTippable() -> Double {
        var isTippable:Double
        if tipSwitch.on
        { isTippable = 1.0}
        else
        { isTippable = 0.0}
        
        return isTippable
    }
    
    
    
    // start round the buttons
    func roundTheButtons() {
       
        
        gotoTopButton.layer.cornerRadius = 0.5 * gotoTopButton.bounds.size.width
        gotoTopButton.layer.borderColor = UIColor.whiteColor().CGColor
        gotoTopButton.layer.borderWidth = 2.0;
        gotoTopButton.layer.masksToBounds = true
        
        
        gotoBottomButton.layer.cornerRadius = 0.5 * gotoBottomButton.bounds.size.width
        gotoBottomButton.layer.borderColor = UIColor.whiteColor().CGColor
        gotoBottomButton.layer.borderWidth = 2.0;
        gotoBottomButton.layer.masksToBounds = true
    }
    // end rounding the buttons
    
    // adding keyboard Done button to decimal pad
    func keyboardSetup() {
        let keyboardDoneButtonView:UIToolbar = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "Done",
            style: .Done,
            target: self,
            action: "doneClicked")
        
        keyboardDoneButtonView.setItems([doneButton], animated:false)

        
        foreignCostField.inputAccessoryView = keyboardDoneButtonView
    }
    
    func doneClicked()
    {
        self.view.endEditing(true)
    }
    // end keyboard done button implementation
    


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
                                localeListSingleton.refreshCountries()
                                self.updateCenterScreen()
                hud.hide(true)
            } else {
                hud.hide(true)
                println("Failed to fetch. Using Cached Config.")
                config = PFConfig.currentConfig()
                                localeListSingleton.refreshCountries()
                                self.updateCenterScreen()
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
            let newTipString = resource["tipString"].string

            exchangeCalc.localeList.localeList.append(Locale(name: localeName, additionalTaxRate: newTax, tipRate: newTip, tipString: newTipString, country: exchangeCalc.localeList.getCountry(newCountryName)))
        }
        
    }
}