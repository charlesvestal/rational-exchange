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

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var foreignView: UIView!
    
    @IBOutlet weak var gotoTopButton: UIButton!
    @IBOutlet weak var gotoBottomButton: UIButton!
    
    
    @IBOutlet weak var foreignCurrencySymbol: UILabel!
    @IBOutlet weak var foreignCostField: UITextField!
    
    @IBAction func fieldChanged(sender : AnyObject) {
        updateCenterScreen()
        defaults.setBool(tipSwitch.on, forKey: "tipSwitch")
        defaults.setObject(foreignCostField.text, forKey: "foreignCostField")
        defaults.synchronize()
    }
    
    @IBOutlet weak var tipSwitch: UISwitch!
    
    
    @IBOutlet weak var homeCostField: UITextField!
    @IBOutlet weak var homeCostLabel: UILabel!
    
    
    
  
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        keyboardSetup()
        roundTheButtons()

        readDefaults()
        parseInit()
        
        updateCenterScreen()
        updateFlags()
        
        foreignView.backgroundColor = UIColor(red: 0.204, green: 0.44, blue: 0.682, alpha: 1.0)
        mainView.backgroundColor = UIColor(red: 0.359, green:0.67, blue:0.857, alpha:1.0)

    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "actOnSpecialNotification", name: mySpecialNotificationKey, object: nil)
    }
    
    
    
    
    
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
 //       printLocales()
    }
    
    @IBAction func gotoButtomButton(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(scrollBottomKey, object: self)
    }
    
    func printLocales() {
        println("{")
        println("\"array\": [")
        
        for locale in exchangeCalc.localeList.localeList {
            
//            {
//                "name": "British Columbia",
//                "additionalTaxRate": 0.1200000000,
//                "tipRate": 0.2000000000,
//                "country": "Canada",
//                "tipString": null
//            },
            
            println("{")
            println (String(format:"\"name\": \"%@\",", locale.name))
            
            if(locale.additionalTaxRate != nil) {
                println (String(format:"\"additionalTaxRate\": %1.5f,", locale.additionalTaxRate!))
            }else {
                println (String(format:"\"additionalTaxRate\": null,"))
            }
            
            if(locale.tipRate != nil) {
                println (String(format:"\"tipRate\": %1.5f,", locale.tipRate!))
            }else {
                println (String(format:"\"tipRate\": null,"))
            }
            
            println (String(format:"\"country\": \"%@\",", locale.country.name))
            
            if(locale.tipString != nil) {
                println (String(format:"\"tipString\": \"%@\"", locale.tipString!))
            }else {
                println (String(format:"\"tipString\": null"))
            }
            println("},")
            
        }
        println("]")
        println("}")
    
    
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
        
        
        if ((exchangeCalc.homeLocale.name == "init") || (exchangeCalc.foreignLocale.name == "init")) {
            homeCostField.text = "?"
        } else {
            homeCostField.text = homeShouldFeelLikeFormated
        }
        
        var errorString1:String = ""
        var errorString2:String = ""
        
        if((foreignCostField.text != "") && (exchangeCalc.homeLocale.name != "init") && (exchangeCalc.foreignLocale.name != "init") ) {
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
            if(foreignCostField.text == ""){
                errorString1 = "Enter an amount above in order to see what it would cost back home."
            }
            
            if (exchangeCalc.homeLocale.name == "init") || (exchangeCalc.foreignLocale.name == "init") {
                if(foreignCostField.text == "") {
                    errorString2 = "\n\n"
                }
                errorString2 += "Swipe up or down to choose your away and home locales."
            }
            
            homeCostLabel.text = errorString1 + errorString2
        }
        
}

    func updateFlags() {
        // update flag buttons
        
        var homeFlag:UIImage? = nil
        var foreignFlag:UIImage? = nil
        
        if (exchangeCalc.homeLocale.name != "init") {
             homeFlag = UIImage(named:exchangeCalc.homeLocale.country.ISOAbbreviation)
        }
        
        if (exchangeCalc.foreignLocale.name != "init") {
            foreignFlag = UIImage(named:exchangeCalc.foreignLocale.country.ISOAbbreviation)
        }
        
        
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
            localeInfo.getDataInBackgroundWithBlock {
                (parseData: NSData!, error: NSError!) -> Void in
                if error == nil {
                    let jsonData = JSONValue(parseData)
                    self.parseLocaleJSON(jsonData)
                    self.readDefaults()
                    self.updateCenterScreen()
                }
            }
            println("Finished processing config from defaults.")
        }
        
        PFConfig.getConfigInBackgroundWithBlock {
            (var config: PFConfig!, error) -> Void in
            if (error == nil) {
                if let localeInfo = config["localeInfo"] as? PFFile {
                 println("Fetch successful. Processing config.")
            localeInfo.getDataInBackgroundWithBlock {
                    (parseData: NSData!, error: NSError!) -> Void in
                    if error == nil {
                        let jsonData = JSONValue(parseData)
                        self.parseLocaleJSON(jsonData)
                        localeListSingleton.refreshCountries()
                        self.readDefaults()
                        self.updateCenterScreen()
                    }
                }
                    println("Finished processing config.")
                }
                
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
        
        exchangeCalc.localeList.localeList.append(Locale(name: "init", additionalTaxRate: 0.057500000, tipRate: 0.20, tipString: nil, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")))
        
    }
}