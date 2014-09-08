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
    
    var selecteTextFieldOriginalY:CGFloat = 0.0;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = true
        
        // Do any additional setup after loading the view, typically from a nib.
        foreignSearchBar.delegate = self
        homeSearchBar.delegate = self

        foreignSearchBar.text = "Prague"
        homeSearchBar.text = "Portland"

        self.automaticallyAdjustsScrollViewInsets = false
      
        setupScrollView()

        updateUI()
    }
    
    func setupScrollView ()
    {
        var numberOfPages:CGFloat = CGFloat(scrollView.subviews.count)
        
        if (currentVersion.doubleValue < 8.0)
        {
        numberOfPages--
        }

        
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
    
    @IBAction func viewTapped(sender : AnyObject) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func homeCostTapped(sender: AnyObject) {
    println("touched")
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        var newCountry = searchBar.text
        
        if(CountryList().countryListDict[newCountry] != nil)
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
    
    
    
    var exchangeCalc = exchangeCalculatorModel(foreignTheyWant: 0,
        foreignCountry: CountryList().countryListDict["Prague"] as Country!,
        homeCountry: CountryList().countryListDict["Portland"] as Country!
        )
    
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
            exchangeCalc.homeTipRate,
            exchangeCalc.calcShouldTaxLike(isTippable),
            exchangeCalc.homeTaxRate
        )
        
        exchangeLabel.text = String(format:"Converting to %@", exchangeCalc.homeCountry.currencyShort) //String(format: "Converting from %@ to %@ at %0.2f", exchangeCalc.foreignCountry.currencyShort, exchangeCalc.homeCountry.currencyShort,exchangeCalc.exchangeRate)
        
        
    }

    func updateForeignCountry(newCountryName:String) {
        let newCountry = CountryList().countryListDict[newCountryName] as Country!
        exchangeCalc.foreignCountry = newCountry
        exchangeCalc.foreignTaxRate = newCountry.taxRate
        exchangeCalc.foreignTipRate = newCountry.tipRate
        let newCountryCurrency = newCountry.currencyShort
        updateUI()
    }
    
    func updateHomeCountry(newCountryName:String) {
        let newCountry = CountryList().countryListDict[newCountryName] as Country!
        exchangeCalc.homeCountry = newCountry
        exchangeCalc.homeTaxRate = newCountry.taxRate
        exchangeCalc.homeTipRate = newCountry.tipRate
        exchangeCalc.homeCountry.exchangeRate = newCountry.exchangeRate
        exchangeCalc.precision = newCountry.precision
        updateUI()
    }
}
