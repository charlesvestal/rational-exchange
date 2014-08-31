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
        }
    
    let tipCalc = TipCalculatorModel(foreignTheyWant: 0,
        foreignCountry: country(taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1.0),
        homeCountry: country(taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.5)
    )
    
    func updateUI()   {
        tipCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
        homeCostField.text = NSString (format: "%.2f", tipCalc.calcShouldFeelLike())
        homeCostLabel.text = String(format: "%0.2f total = %0.2f + %0.2f tip + %0.2f tax",
            tipCalc.calcTotalAmount(),
            tipCalc.calcShouldFeelLike(),
            tipCalc.calcShouldTipLike(),
            tipCalc.calcShouldTaxLike())
    }

    func updateCountries(homeCountry: country, foreignCountry:country) {
        tipCalc.homeCountry = homeCountry
        tipCalc.foreignCountry = foreignCountry
        updateUI()
    }
    
    
    var countries: Dictionary<String, Any> = [
        "Country": "Name",
        "Object": country(taxRate: 0.1, tipRate: 0.2, exchangeRate: 0.3, precision: 0.4),
    ]
    
    override func awakeFromNib() {
        let usa = country(taxRate: 0.825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25)
        let norway = country(taxRate: 0.825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25)
        let euro = country(taxRate: 0.825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25)
        
        countries = ["USA": usa, "Euro": euro, "Norway": norway]
     }

}
