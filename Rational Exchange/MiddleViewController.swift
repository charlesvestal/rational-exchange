//
//  MiddleViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 10/8/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class CVMiddleViewController: UIViewController {
    
    @IBOutlet weak var gotoTopButton: UIButton!
    @IBOutlet weak var gotoBottomButton: UIButton!
    
    
    @IBOutlet weak var foreignCurrencySymbol: UILabel!
    @IBOutlet weak var foreignCostField: UITextField!
    
    @IBAction func fieldChanged(sender : AnyObject) {
        updateCenterScreen()
//        defaults.setBool(tipSwitch.on, forKey: "tipSwitch")
//        defaults.synchronize()
    }
    
    @IBOutlet weak var tipSwitch: UISwitch!
    
    @IBOutlet weak var homeCostField: UITextField!
    @IBOutlet weak var homeCostLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardSetup()
        roundTheButtons()
        
        updateCenterScreen()

        exchangeCalc.localeList.refreshCountries()
    }
    
    
    func updateCenterScreen(){
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
        
        
        
//        if(foreignCostField.text != "" && exchangeCalc.homeLocale.name != "Choose a Locale" && exchangeCalc.foreignLocale.name != "Choose a Locale") {
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
        }
    }
    
    
    // start return tippable
    func isTippable() -> Double {
        var isTippable:Double
        if tipSwitch.on
        { isTippable = 1.0}
        else
        { isTippable = 0.0}
        
        return isTippable
    }
    // end return tippable
    
    
    
    // start round the buttons
    func roundTheButtons() {
        gotoTopButton.layer.cornerRadius = 0.5 * gotoTopButton.bounds.size.width
        gotoTopButton.layer.masksToBounds = true
        
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
}