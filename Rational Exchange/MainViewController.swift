//
//  ViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
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
    
//    @IBOutlet weak var exchangeLabel: UILabel!
    
    
    
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    var exchangeCalc = exchangeCalculator(foreignTheyWant: 0,
        foreignLocale:  localeListSingleton.getLocale("Oslo"),
        homeLocale:  localeListSingleton.getLocale("United States (USA)")
    )

    func setDefaults() {
      //  defaults.setObject(localeListSingleton, forKey: "localeListSingleton")
        defaults.setObject(exchangeCalc.homeLocale.name, forKey: "homeLocaleName")
        defaults.setObject(exchangeCalc.foreignLocale.name, forKey: "foreignLocaleName")
        defaults.setObject(foreignCostField.text, forKey: "foreignCostField")
        defaults.synchronize()
    }
    
    func readDefaults()
    {
 
        if let homeLocaleisNotNil = defaults.objectForKey("homeLocaleName") as? String {
            exchangeCalc.homeLocale = localeListSingleton.getLocale(defaults.objectForKey("homeLocaleName") as String)
        }
  
        if let foreignLocaleisNotNil = defaults.objectForKey("foreignLocaleName") as? String {
            exchangeCalc.foreignLocale = localeListSingleton.getLocale(defaults.objectForKey("foreignLocaleName") as String)
        }
        
        if let foreignCostisNotNil = defaults.objectForKey("foreignCostField") as? String {
            foreignCostField.text = defaults.objectForKey("foreignCostField") as String
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readDefaults()
        
        self.navigationController?.navigationBarHidden = true
           self.automaticallyAdjustsScrollViewInsets = false
        
        initUI()
        setupScrollView()
        updateUI()
        
         }
    
    func setupScrollView ()
    {
        var numberOfPages:CGFloat = CGFloat(scrollView.subviews.count) - 1
        
        scrollView.contentSize = CGSize(width: mainView.bounds.width, height: (mainView.bounds.height * (numberOfPages - 1)))
       
        let startingPage:CGFloat = 1
            scrollView.contentOffset = CGPointMake(0,(mainView.bounds.height * startingPage))
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
        updateUI()
    }
    
    func doneClicked()
    {
        self.view.endEditing(true)
    }
    
   func initUI()
   {
        let keyboardDoneButtonView:UIToolbar = UIToolbar()
            keyboardDoneButtonView.sizeToFit()
        
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "Done",
            style: .Done,
            target: self,
            action: "doneClicked")
        
        keyboardDoneButtonView.setItems([doneButton], animated:false)
    
        foreignCostField.inputAccessoryView = keyboardDoneButtonView
    
        localeListSingleton.refreshCountries()
    }
    
    func updateUI()   {
        var homeFormatter = NSNumberFormatter()
        homeFormatter.numberStyle = .CurrencyStyle
        homeFormatter.currencyCode = exchangeCalc.homeLocale.country.currencyCode

        var foreignFormatter = NSNumberFormatter()
        foreignFormatter.numberStyle = .CurrencyStyle
        foreignFormatter.currencyCode = exchangeCalc.foreignLocale.country.currencyCode


        var foreignCurrencySymbol = foreignFormatter.stringFromNumber(0)
        var nonNumberCharacterSet = NSMutableCharacterSet.decimalDigitCharacterSet()
            //nonNumberCharacterSet.invert()
        foreignCurrencySymbol = foreignCurrencySymbol.componentsSeparatedByCharactersInSet(nonNumberCharacterSet)[0]
        
        
        foreignCurrencySymbolLabel.text = foreignCurrencySymbol
        
        var isTippable:Double
        if tipSwitch.on
        { isTippable = 1.0}
        else
        { isTippable = 0.0}
        
        exchangeCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
        
        exchangeCalc.calcExchangeRate()

        // set up foreign labels
        topFrameLocaleName.text = exchangeCalc.foreignLocale.name.uppercaseString
        topFrameCurrencyName.text = String(format:"%@ (%@)", exchangeCalc.foreignLocale.country.currencyName, exchangeCalc.foreignLocale.country.currencyCode)
      
            if(exchangeCalc.foreignLocale.additionalTaxRate == 0){
                topFrameTaxString.text = "Nothing! Tax is included."
            }
            else if(exchangeCalc.foreignLocale.additionalTaxRate == nil) {
                topFrameTaxString.text = "We don't know about tax."
            }
            else {
                topFrameTaxString.text = String(format: "%.2f%% in Sales Tax", exchangeCalc.foreignLocale.additionalTaxRate! * 100)
            }

            if (exchangeCalc.foreignLocale.tipRate == 0.0){
                topFrameTipString.text = "Nada. Don't worry about it."
            }
            else if(exchangeCalc.foreignLocale.tipRate == nil) {
                topFrameTaxString.text = "We don't know about tip."
            }
            else {
                topFrameTipString.text = String(format: "%.2f%% for Gratiuity", exchangeCalc.foreignLocale.tipRate! * 100)
            }
        
        // set up home labels
        bottomFrameLocaleName.text = exchangeCalc.homeLocale.name.uppercaseString
        bottomFrameCurrencyName.text = String(format:"%@ (%@)", exchangeCalc.homeLocale.country.currencyName, exchangeCalc.homeLocale.country.currencyCode)
        
        if (exchangeCalc.homeLocale.additionalTaxRate == 0.0){
            bottomFrameTaxString.text = "No tax is added."
        }
        else if(exchangeCalc.homeLocale.additionalTaxRate == nil) {
            if(exchangeCalc.homeLocale.country.taxString == nil){
                bottomFrameTaxString.text = "We don't know about tax."
            }
            else {
                bottomFrameTaxString.text = exchangeCalc.homeLocale.country.taxString
            }
        }
        else {
            bottomFrameTaxString.text = String(format: "%.2f%% in Sales Tax", exchangeCalc.homeLocale.additionalTaxRate! * 100)
        }
        
        
        
        
        if (exchangeCalc.homeLocale.tipRate == 0.0){
            bottomFrameTipString.text = "No tip necessary."
        }
        else if(exchangeCalc.homeLocale.tipRate == nil) {
            if(exchangeCalc.homeLocale.country.tipString == nil){
                bottomFrameTipString.text = "We don't know about tip."
            }
            else {
                bottomFrameTipString.text = exchangeCalc.homeLocale.country.tipString
            }
        }
        else {
            bottomFrameTipString.text = String(format: "%.2f%% for Gratiuity", exchangeCalc.homeLocale.tipRate! * 100)
        }
        
 
        homeCostField.text = NSString (format: "%@",
            homeFormatter.stringFromNumber(exchangeCalc.calcShouldFeelLikeRounded(isTippable))
            )
        
        if(foreignCostField.text != "")
        {
                homeFormatter.currencyCode = exchangeCalc.homeLocale.country.currencyCode
            
                homeCostLabel.text = String(format: "Your total cost is going to be %@. But back home, if it was listed as %@, you would pay an additional %@ tax, and tip %@",
                homeFormatter.stringFromNumber(exchangeCalc.calcTotalAmount(isTippable)),
                //exchangeCalc.homeLocale.currencyCode,
                homeFormatter.stringFromNumber(exchangeCalc.calcShouldFeelLike(isTippable)),
                homeFormatter.stringFromNumber(exchangeCalc.calcShouldTaxLike(isTippable)),
                homeFormatter.stringFromNumber(exchangeCalc.calcShouldTipLike(isTippable))
            )
        }
      setDefaults()
    }
    


    func updateForeignLocale(newLocaleName:String) {
        let newLocale = exchangeCalc.localeList.getLocale(newLocaleName)
        exchangeCalc.foreignLocale = newLocale
        exchangeCalc.foreignLocale.additionalTaxRate = newLocale.additionalTaxRate
        exchangeCalc.foreignLocale.tipRate = newLocale.tipRate
        let newLocaleCurrency = newLocale.country.currencyCode
        updateUI()
    }
    
    func updateHomeLocale(newLocaleName:String) {
        let newLocale = exchangeCalc.localeList.getLocale(newLocaleName)
        exchangeCalc.homeLocale = newLocale
        exchangeCalc.homeLocale.additionalTaxRate = newLocale.additionalTaxRate
        exchangeCalc.homeLocale.tipRate = newLocale.tipRate
        exchangeCalc.homeLocale.country.exchangeRate = newLocale.country.exchangeRate
        exchangeCalc.precision = newLocale.country.precision
        updateUI()
    }
    

}

