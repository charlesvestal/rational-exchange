//
//  CVMiddleViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 10/8/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation


class CVMiddleViewController: UIViewController {

    @IBOutlet weak var gotoTopButton: UIButton!
    @IBOutlet weak var gotoBottomButton: UIButton!
    
    
    @IBOutlet weak var foreignBackground: UIView!
    @IBOutlet weak var thePriceTagSays: UILabel!
    @IBOutlet weak var foreignCurrencySymbol: UILabel!
    @IBOutlet weak var foreignCostField: UITextField!
    @IBOutlet weak var barRestaurantLabel: UILabel!
    @IBOutlet weak var tipSwitch: UISwitch!
    
    
    @IBAction func fieldChanged(sender : AnyObject) {
        updateCenterScreen()
        defaults.setBool(tipSwitch.on, forKey: "tipSwitch")
        defaults.synchronize()
    }
    
    
    @IBOutlet var homeBackground: UIView!
    @IBOutlet weak var backHomeLabel: UILabel!
    @IBOutlet weak var homeCostField: UITextField!
    @IBOutlet weak var homeCostLabel: UILabel!
    
    
    
  
    override func viewDidLoad() {
        
        super.viewDidLoad()
        keyboardSetup()
        roundTheButtons()

        readDefaults()
        parseInit()

        updateCenterScreen()
        updateFlagsandColors()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "actOnSpecialNotification", name: mySpecialNotificationKey, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        var bottomBorder:CALayer = CALayer()
        bottomBorder.frame = CGRectMake(0.0, foreignBackground.bounds.height, foreignBackground.frame.size.width, 1.0)
        println(bottomBorder.frame)
        bottomBorder.backgroundColor = UIColor.lightTextColor().CGColor
        foreignBackground.layer.addSublayer(bottomBorder)

        
    }
    
    func actOnSpecialNotification() {
        updateCenterScreen()
        updateFlagsandColors()
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

    
    func updateCenterScreen(){
   
        let currentForeignName = exchangeCalc.foreignLocale.name
        let currentHomeName = exchangeCalc.homeLocale.name
        exchangeCalc.updateLocale(currentForeignName, isForeign:true)
        exchangeCalc.updateLocale(currentHomeName, isForeign:false)
        
        // set the exchangeCalc singleton value to the foreign Cost lable
        exchangeCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
        
        // set formatters for home and foreign currency
        var homeFormatter = NSNumberFormatter()
        homeFormatter.numberStyle = .CurrencyStyle
        homeFormatter.currencyCode = exchangeCalc.homeLocale.country.currencyCode
    
        var foreignFormatter = NSNumberFormatter()
        foreignFormatter.numberStyle = .CurrencyStyle
        foreignFormatter.currencyCode = exchangeCalc.foreignLocale.country.currencyCode
        
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
            var startString = String(format:"With %@ tax and %@ tip, y", foreignTax, foreignTip)

            // change the ending language, depending on if your foreign and home total amounts are identical (no need to list them twice)
            if (foreignTotalAmount! != homeTotalAmount){
                totalCostString = String(format:"our total is going to be %@, or %@", foreignTotalAmount!, homeTotalAmount!)
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
                andString = " and "
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

    func updateFlagsandColors() {
        // update flag buttons
        var homeFlag = UIImage(named:exchangeCalc.homeLocale.country.ISOAbbreviation)
        var foreignFlag = UIImage(named:exchangeCalc.foreignLocale.country.ISOAbbreviation)
        
        let tintColor = UIColor(white:0.2, alpha:0.5)
        

        
        self.gotoTopButton.setBackgroundImage(foreignFlag?.applyBlurWithRadius(5, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil), forState: .Normal)
        self.gotoBottomButton.setBackgroundImage(homeFlag?.applyBlurWithRadius(5, tintColor: tintColor, saturationDeltaFactor: 1.8, maskImage: nil), forState: .Normal)
        
      // update colors based on flags
        var foreignColorArt:SLColorArt = foreignFlag!.colorArt()
        var homeColorArt:SLColorArt = homeFlag!.colorArt()
        
        foreignBackground.backgroundColor = foreignColorArt.backgroundColor
        thePriceTagSays.textColor = foreignColorArt.primaryColor
        foreignCurrencySymbol.textColor = foreignColorArt.secondaryColor
        barRestaurantLabel.textColor = foreignColorArt.secondaryColor
        
        homeBackground.backgroundColor = homeColorArt.backgroundColor
        backHomeLabel.textColor = homeColorArt.secondaryColor
        homeCostField.textColor = homeColorArt.primaryColor
        homeCostLabel.textColor = homeColorArt.secondaryColor
        

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
        gotoTopButton.layer.borderWidth = 1.0;
        gotoTopButton.layer.masksToBounds = true
        
        gotoBottomButton.layer.borderColor = UIColor.whiteColor().CGColor
        gotoBottomButton.layer.borderWidth = 1.0;
        gotoBottomButton.layer.cornerRadius = 0.5 * gotoBottomButton.bounds.size.width
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