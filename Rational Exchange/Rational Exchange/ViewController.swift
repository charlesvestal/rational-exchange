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
        updateForeignCountry(countries["Euro"]!)
        foreignLabel.text = String(format: "In Euro")
        //TODO: either pull key as the name or add currency code to Country model
    }
    
    
    @IBAction func norwayButtonPressed(sender: AnyObject) {
     updateForeignCountry(countries["Norway"]!)
        foreignLabel.text = String(format: "In Norway")
    }
    
    var tipCalc = TipCalculatorModel(foreignTheyWant: 0,
        foreignCountry: country(taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1.0),
        homeCountry: country(taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.5)
        // TODO set up defaults and remember user state
    )
    
    func updateUI()   {
        tipCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
        tipCalc.calcExchangeRate()
        homeCostField.text = NSString (format: "%.2f", tipCalc.calcShouldFeelLike())
        homeCostLabel.text = String(format: "%0.2f total = %0.2f + %0.2f tip + %0.2f tax",
            tipCalc.calcTotalAmount(),
            tipCalc.calcShouldFeelLike(),
            tipCalc.calcShouldTipLike(),
            tipCalc.calcShouldTaxLike())
    }

    func updateForeignCountry(newForeignCountry:AnyObject) {
        tipCalc.foreignCountry = newForeignCountry as country
        updateUI()
    }
    
    
    var countries: Dictionary<String, AnyObject> = [
        "Country": country(taxRate: 0.0, tipRate: 0.0, exchangeRate: 0.0, precision: 0.0)
    ]
    
    override func awakeFromNib() {
     
        countries = [
                    "USA": country(taxRate: 0.825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25),
                    "Euro": country(taxRate: 0, tipRate: 0, exchangeRate: 0.76, precision: 1),
                    "Norway": country(taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1)
                    ]
     }

}
