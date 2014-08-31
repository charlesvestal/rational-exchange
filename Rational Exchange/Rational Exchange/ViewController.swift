//
//  ViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var foreignCostField: UITextField!
    @IBOutlet weak var homeCostField: UITextField!
    @IBOutlet weak var homeCostLabel: UILabel!
    @IBOutlet weak var euroButton: UIButton!
    @IBOutlet weak var norwayButton: UIButton!
    @IBOutlet weak var foreignLabel: UILabel!
    @IBOutlet weak var tipSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    @IBAction func euroButtonPressed(sender: AnyObject) {
        updateForeignCountry("Euro")
    }
    
    @IBAction func norwayButtonPressed(sender: AnyObject) {
        updateForeignCountry("Norway")
    }
    
    var countries: Dictionary<String, AnyObject> = [
        "Country": country(taxRate: 0.0, tipRate: 0.0, exchangeRate: 0.0, precision: 0.0, currencyShort:"")
    ] // is there a better way to set up the array here?
    
    override func awakeFromNib() {
        countries = [
            "USA": country(taxRate: 0.825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyShort:"USD"),
            "Euro": country(taxRate: 0, tipRate: 0, exchangeRate: 0.76, precision: 1, currencyShort:"EUR"),
            "Norway": country(taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1, currencyShort:"NOK")
        ]
    }
    
    var exchangeCalc = exchangeCalculatorModel(foreignTheyWant: 0,
        foreignCountry: country(taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1.0, currencyShort:"NOK"),
        homeCountry: country(taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.5, currencyShort:"USD")
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
        homeCostField.text = NSString (format: "%.2f", exchangeCalc.calcShouldFeelLike(isTippable))
        homeCostLabel.text = String(format: "%0.2f total = %0.2f + %0.2f tip + %0.2f tax",
            exchangeCalc.calcTotalAmount(isTippable),
            exchangeCalc.calcShouldFeelLike(isTippable),
            exchangeCalc.calcShouldTipLike(isTippable),
            exchangeCalc.calcShouldTaxLike(isTippable))
       
    }

    func updateForeignCountry(newCountryName:String) {
        let newCountry: country? = countries[newCountryName] as? country
        exchangeCalc.foreignCountry = newCountry!
        let newCountryCurrency = newCountry?.currencyShort
        foreignLabel.text = String(format: "In %@", newCountryCurrency!)
        updateUI()
    }
    
    func updateHomeCountry(newHomeCountry:AnyObject) {
        exchangeCalc.homeCountry = newHomeCountry as country
        updateUI()
    }
}
