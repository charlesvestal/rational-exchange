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

    @IBOutlet weak var middlePage: UIView!
    @IBOutlet weak var foreignCostField: UITextField!
    @IBOutlet weak var homeCostField: UILabel!
    @IBOutlet weak var homeCostLabel: UILabel!
//    @IBOutlet weak var foreignLabel: UILabel!
    @IBOutlet weak var tipSwitch: UISwitch!
    
  
    @IBOutlet weak var topFrameLocaleName: UILabel!
    @IBOutlet weak var topFrameCurrencyName: UILabel!
    @IBOutlet weak var topFrameTaxString: UILabel!
    @IBOutlet weak var topFrameTipString: UILabel!

    @IBOutlet weak var bottomFrameLocaleName: UILabel!
    @IBOutlet weak var bottomFrameCurrencyName: UILabel!
    @IBOutlet weak var bottomFrameTaxString: UILabel!
    @IBOutlet weak var bottomFrameTipString: UILabel!
    
//    @IBOutlet weak var exchangeLabel: UILabel!
    
    var exchangeCalc = exchangeCalculator(foreignTheyWant: 0,
        foreignLocale:  localeListSingleton.getLocale("Oslo"),
        homeLocale:  localeListSingleton.getLocale("Texas")
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
        localeListSingleton.refreshLocales()
    }
    
    func updateUI()   {
        
        var homeFormatter = NSNumberFormatter()
        homeFormatter.numberStyle = .CurrencyStyle
        homeFormatter.currencyCode = exchangeCalc.homeLocale.currencyCode

        var foreignFormatter = NSNumberFormatter()
        foreignFormatter.numberStyle = .CurrencyStyle
        foreignFormatter.currencyCode = exchangeCalc.foreignLocale.currencyCode


        var foreignCurrencySymbol = foreignFormatter.stringFromNumber(0)
        var nonNumberCharacterSet = NSMutableCharacterSet.decimalDigitCharacterSet()
            //nonNumberCharacterSet.invert()
        foreignCurrencySymbol = foreignCurrencySymbol.componentsSeparatedByCharactersInSet(nonNumberCharacterSet)[0]
        
        println(foreignCurrencySymbol)
        
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
        topFrameCurrencyName.text = String(format:"%@ (%@)", exchangeCalc.foreignLocale.currencyName, exchangeCalc.foreignLocale.currencyCode)
      
            if(exchangeCalc.foreignLocale.taxRate == 0){
                topFrameTaxString.text = "Nothing! Tax is included."
            }
            else {
                topFrameTaxString.text = String(format: "%.2f%% in Sales Tax", exchangeCalc.foreignLocale.taxRate * 100)
            }

            if (exchangeCalc.foreignLocale.tipRate == 0.0){
                topFrameTipString.text = "Nada. Don't worry about it."
            }
            else {
                topFrameTipString.text = String(format: "%.2f%% for Gratiuity", exchangeCalc.foreignLocale.tipRate * 100)
            }
        
        // set up home labels
        bottomFrameLocaleName.text = exchangeCalc.homeLocale.name.uppercaseString
        bottomFrameCurrencyName.text = String(format:"%@ (%@)", exchangeCalc.homeLocale.currencyName, exchangeCalc.homeLocale.currencyCode)
        
        if(exchangeCalc.homeLocale.taxRate == 0){
            bottomFrameTaxString.text = "Nothing! Tax is included."
        }
        else {
            bottomFrameTaxString.text = String(format: "%.2f%% in Sales Tax", exchangeCalc.homeLocale.taxRate * 100)
        }
        
        if (exchangeCalc.homeLocale.tipRate == 0.0){
            bottomFrameTipString.text = "Nada. Don't worry about it."
        }
        else {
            bottomFrameTipString.text = String(format: "%.2f%% for Gratiuity", exchangeCalc.homeLocale.tipRate * 100)
        }
        
 
        homeCostField.text = NSString (format: "%@",
            homeFormatter.stringFromNumber(exchangeCalc.calcShouldFeelLikeRounded(isTippable))
            )
        
        if(foreignCostField.text != "")
        {
                homeFormatter.currencyCode = exchangeCalc.homeLocale.currencyCode
            
                homeCostLabel.text = String(format: "Your total cost is going to be %@. But back home, if it was listed as %@, you would pay an additional %@ tax, and tip %@",
                homeFormatter.stringFromNumber(exchangeCalc.calcTotalAmount(isTippable)),
                //exchangeCalc.homeLocale.currencyCode,
                homeFormatter.stringFromNumber(exchangeCalc.calcShouldFeelLike(isTippable)),
                homeFormatter.stringFromNumber(exchangeCalc.calcShouldTipLike(isTippable)),
                homeFormatter.stringFromNumber(exchangeCalc.calcShouldTaxLike(isTippable))
            )
        }
        
        // exchangeLabel.text = String(format:"Converting to %@", exchangeCalc.homeLocale.currencyCode)
        
        
    }

    func updateForeignLocale(newLocaleName:String) {
        let newLocale = exchangeCalc.localeList.getLocale(newLocaleName)
        exchangeCalc.foreignLocale = newLocale
        exchangeCalc.foreignLocale.taxRate = newLocale.taxRate
        exchangeCalc.foreignLocale.tipRate = newLocale.tipRate
        let newLocaleCurrency = newLocale.currencyCode
        updateUI()
    }
    
    func updateHomeLocale(newLocaleName:String) {
        let newLocale = exchangeCalc.localeList.getLocale(newLocaleName)
        exchangeCalc.homeLocale = newLocale
        exchangeCalc.homeLocale.taxRate = newLocale.taxRate
        exchangeCalc.homeLocale.tipRate = newLocale.tipRate
        exchangeCalc.homeLocale.exchangeRate = newLocale.exchangeRate
        exchangeCalc.precision = newLocale.precision
        updateUI()
    }
    

}

