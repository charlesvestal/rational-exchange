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
    
    @IBOutlet weak var middlePage: UIView!
    @IBOutlet weak var foreignCostField: UITextField!
    @IBOutlet weak var homeCostField: UILabel!
    @IBOutlet weak var homeCostLabel: UILabel!
    @IBOutlet weak var foreignLabel: UILabel!
    @IBOutlet weak var tipSwitch: UISwitch!
    
  
    
    @IBOutlet weak var foreignSearchBar: UISearchBar!
    @IBOutlet weak var homeSearchBar: UISearchBar!
    
    @IBOutlet weak var exchangeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        // Do any additional setup after loading the view, typically from a nib.
        homeSearchBar.delegate = self
        homeSearchBar.text = "Portland"

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
            println("probably 7")
        }
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
    
    
    @IBAction func homeCostTapped(sender: AnyObject) {
    println("touched")
    }
    
    
    var exchangeCalc = exchangeCalculator(foreignTheyWant: 0,
        foreignCountry:  countryListSingleton.getCountry("Prague"),
        homeCountry:  countryListSingleton.getCountry("Portland")
    )

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

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        var newCountry = searchBar.text
        
        if(exchangeCalc.countryList.getCountry(newCountry).name != "None")
        {
            if(searchBar==homeSearchBar)
            {
                updateHomeCountry(newCountry)
            }
            else if(searchBar==foreignSearchBar)
            {
                updateForeignCountry(newCountry)
            }
            searchBar.resignFirstResponder()
        }
        else
        {
            unsupportedCountries()
        }
    }
    

    func searchBarShouldEndEditing(searchBar: UISearchBar!) {
         searchBarSearchButtonClicked(searchBar)
    }
    
    
    func unsupportedCountries()
    {
        let alert = UIAlertView()
        alert.title = "Unsupported Country"
        alert.message = "Try Prague, Norway, USA, Portland, Euro, Magic10 or Magic20"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    

    
    //reference
    
    // or you can just access properties and call methods directly
   

    
    func updateUI()   {
        
        var isTippable:Double
        if tipSwitch.on
        { isTippable = 1.0}
        else
        { isTippable = 0.0}
        
        exchangeCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
        
        exchangeCalc.calcExchangeRate()

        foreignLabel.text = String(format: "Converting from %@", exchangeCalc.foreignCountry.currencyShort)

        homeCostField.text = NSString (format: "$%.2f %@",
            exchangeCalc.calcShouldFeelLikeRounded(isTippable),
            exchangeCalc.homeCountry.currencyShort)
        
        homeCostLabel.text = String(format: "it will cost you $%0.2f in %@ total, but think about it like $%0.2f on the menu + you would tip $%0.2f at home at %0.2f + you would pay $%0.2f in tax at %0.4f",
            exchangeCalc.calcTotalAmount(isTippable),
            exchangeCalc.homeCountry.currencyShort,
            exchangeCalc.calcShouldFeelLike(isTippable),
            exchangeCalc.calcShouldTipLike(isTippable),
            exchangeCalc.homeCountry.tipRate,
            exchangeCalc.calcShouldTaxLike(isTippable),
            exchangeCalc.homeCountry.taxRate
        )
        
        exchangeLabel.text = String(format:"Converting to %@", exchangeCalc.homeCountry.currencyShort) //String(format: "Converting from %@ to %@ at %0.2f", exchangeCalc.foreignCountry.currencyShort, exchangeCalc.homeCountry.currencyShort,exchangeCalc.exchangeRate)
        
        
    }

    func updateForeignCountry(newCountryName:String) {
        let newCountry = exchangeCalc.countryList.getCountry(newCountryName)
        exchangeCalc.foreignCountry = newCountry
        exchangeCalc.foreignCountry.taxRate = newCountry.taxRate
        exchangeCalc.foreignCountry.tipRate = newCountry.tipRate
        let newCountryCurrency = newCountry.currencyShort
        updateUI()
    }
    
    func updateHomeCountry(newCountryName:String) {
        let newCountry = exchangeCalc.countryList.getCountry(newCountryName)
        exchangeCalc.homeCountry = newCountry
        exchangeCalc.homeCountry.taxRate = newCountry.taxRate
        exchangeCalc.homeCountry.tipRate = newCountry.tipRate
        exchangeCalc.homeCountry.exchangeRate = newCountry.exchangeRate
        exchangeCalc.precision = newCountry.precision
        updateUI()
    }
}
