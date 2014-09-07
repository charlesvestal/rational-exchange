//
//  ViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {


    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var middlePage: UIView!
    @IBOutlet weak var foreignCostField: UITextField!
    @IBOutlet weak var homeCostField: UITextField!
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

        foreignSearchBar.text = "Norway"
        homeSearchBar.text = "USA"

        self.automaticallyAdjustsScrollViewInsets = false
        
        var numberOfPages:CGFloat = CGFloat(scrollView.subviews.count)
        
        let startingPage:CGFloat = 1
        
        scrollView.contentSize = CGSize(width: mainView.bounds.width, height: (mainView.bounds.height * numberOfPages))

        
        scrollView.contentOffset = CGPointMake(0,(mainView.bounds.height * startingPage))
        
        middlePage.bounds = CGRect(x: middlePage.bounds.origin.x, y: (mainView.bounds.height * -1), width: middlePage.bounds.width, height: middlePage.bounds.height)
        
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
       updateUI()
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
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
        var newCountry = searchBar.text
        
        if(countries[newCountry] != nil)
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
        alert.message = "Try Norway, USA, Euro, Magic10 or Magic20"
        alert.addButtonWithTitle("OK")
        alert.show()
    }
    
    var countries: Dictionary<String, AnyObject> = [
        "Country": Country(name:"Default", taxRate: 0.0, tipRate: 0.0, exchangeRate: 0.0, precision: 0.0, currencyShort:"")
    ] // is there a better way to set up the array here?
    
    override func awakeFromNib() {
        countries = [
            "USA":  Country(name:"USA", taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyShort:"USD"),
            "Euro": Country(name:"Euro", taxRate: 0, tipRate: 0, exchangeRate: 0.76, precision: 1, currencyShort:"EUR"),
            "Norway": Country(name:"Norway", taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1, currencyShort:"NOK"),
            "Magic10": Country(name:"Magic10", taxRate: 0.1, tipRate: 0.1, exchangeRate: 1, precision: 1, currencyShort:"M10"),
            "Magic20": Country(name:"Magic20", taxRate: 0.2, tipRate: 0.2, exchangeRate: 1, precision: 1, currencyShort:"M20")
        ]
        
        // ideally pull this in from an eternal data source to eventually hit an API
    }
    
    var exchangeCalc = exchangeCalculatorModel(foreignTheyWant: 0,
        foreignCountry: Country(name:"Norway", taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1.0, currencyShort:"NOK"),
        homeCountry: Country(name:"USA", taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyShort:"USD")
        // TODO set up defaults and remember user state
        // Is there a way to set this up using the countries dict we already have? IE foreignCountry: countries["Norway"]
    )
    
    func updateUI()   {
        var isTippable:Double
        if tipSwitch.on
        { isTippable = 1.0}
        else
        { isTippable = 0.0}
        
        exchangeCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
        
        exchangeCalc.calcExchangeRate()

        foreignLabel.text = String(format: "The price in %@", exchangeCalc.foreignCountry.currencyShort)

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
        
        exchangeLabel.text = String(format: "Converting from %@ to %@ at %0.2f", exchangeCalc.foreignCountry.currencyShort, exchangeCalc.homeCountry.currencyShort,exchangeCalc.exchangeRate)
        
        
    }

    func updateForeignCountry(newCountryName:String) {
        let newCountry = countries[newCountryName] as Country
        exchangeCalc.foreignCountry = newCountry
        exchangeCalc.foreignTaxRate = newCountry.taxRate
        exchangeCalc.foreignTipRate = newCountry.tipRate
        let newCountryCurrency = newCountry.currencyShort
        updateUI()
    }
    
    func updateHomeCountry(newCountryName:String) {
        let newCountry = countries[newCountryName] as Country
        exchangeCalc.homeCountry = newCountry
        exchangeCalc.homeTaxRate = newCountry.taxRate
        exchangeCalc.homeTipRate = newCountry.tipRate
        exchangeCalc.homeCountry.exchangeRate = newCountry.exchangeRate
        exchangeCalc.precision = newCountry.precision
        updateUI()
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let dict:NSDictionary = sender.userInfo! as NSDictionary
        let s:NSValue = dict.valueForKey(UIKeyboardFrameEndUserInfoKey) as NSValue;
        let rect :CGRect = s.CGRectValue();
        
        let k:NSValue = dict.valueForKey(UIKeyboardFrameBeginUserInfoKey) as NSValue
        let kRect: CGRect = k.CGRectValue()
        
        if self.homeSearchBar.isFirstResponder() { // figure out how to get this first and not run through any of this
            var frame = self.homeSearchBar.frame;
            selecteTextFieldOriginalY = frame.origin.y;
            
            var offset = (kRect.height) ;
            print(offset)
            frame.origin.y = offset>0 ? frame.origin.y - offset : frame.origin.y ;
            UIView.animateWithDuration(0.3, animations:{
                self.homeSearchBar.frame = frame;
                })
        }
    }

    
    
    func keyboardWillHide(sender: NSNotification) {
        let dict:NSDictionary = sender.userInfo! as NSDictionary
        let s:NSValue = dict.valueForKey(UIKeyboardFrameBeginUserInfoKey) as NSValue
        let rect :CGRect = s.CGRectValue()
        var frame = self.homeSearchBar.frame
        frame.origin.y = selecteTextFieldOriginalY
        
       // if self.homeSearchBar.isFirstResponder() { // figure out how to get this first and not run through any of this
            UIView.animateWithDuration(0.3, animations:{
            self.homeSearchBar.frame = frame;
            })
        //}
    }
}
