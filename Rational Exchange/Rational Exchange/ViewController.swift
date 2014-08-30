//
//  ViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 8/29/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var foreignTaxField: UITextField!
    @IBOutlet weak var foreignTipField: UITextField!
    @IBOutlet weak var foreignExchangeField: UITextField!
    @IBOutlet weak var foreignCostField: UITextField!
    @IBOutlet weak var homeCostField: UITextField!
    @IBOutlet weak var homeCostLabel: UILabel!
    @IBOutlet weak var homeTaxField: UITextField!
    @IBOutlet weak var homeTipField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initUI()
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
    
    @IBAction func resetButtonPressed(sender: AnyObject) {
        let norway = country(taxRate: 0.0, tipRate: 0.0, exchangeRate:6, precision:1.0)
        let usa = country(taxRate: 0.0825, tipRate: 0.2, exchangeRate:1, precision:0.5)
        resetUI(usa, foreignCountry: norway)
    }
    
    let tipCalc = TipCalculatorModel(foreignTheyWant: 96,
        foreignCountry: country(taxRate: 0, tipRate: 0, exchangeRate: 6.0, precision: 1.0),
        homeCountry: country(taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.5)
    )
    
    func initUI() {
        foreignTaxField.text = String(format: "%0.2f", tipCalc.foreignTaxRate)
        foreignTipField.text = String(format: "%0.2f", tipCalc.foreignTipRate)
        foreignExchangeField.text = String(format: "%0.2f", tipCalc.exchangeRate)
        foreignCostField.text = String(format: "%0.2f", tipCalc.foreignTheyWant)
        homeCostField.text = String(format: "%0.2f", tipCalc.calcShouldFeelLike())
        homeCostLabel.text = String(format: "%0.2f total = %0.2f + %0.2f tip + %0.2f tax",
            tipCalc.calcTotalAmount(),
            tipCalc.calcShouldFeelLike(),
            tipCalc.calcShouldTipLike(),
            tipCalc.calcShouldTaxLike())
        homeTaxField.text = String(format: "%0.4f", tipCalc.homeTaxRate)
        homeTipField.text = String(format: "%0.2f", tipCalc.homeTipRate)
    }

    func updateUI()   {
        tipCalc.foreignTaxRate =  Double((foreignTaxField.text as NSString).doubleValue)
        tipCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
        tipCalc.exchangeRate =  Double((foreignExchangeField.text as NSString).doubleValue)
        tipCalc.foreignTipRate = Double((foreignTipField.text as NSString).doubleValue)
        tipCalc.homeTaxRate =  Double((homeTaxField.text as NSString).doubleValue)
        tipCalc.homeTipRate =  Double((homeTipField.text as NSString).doubleValue)
        homeCostField.text = NSString (format: "%.2f", tipCalc.calcShouldFeelLike())
        homeCostLabel.text = String(format: "%0.2f total = %0.2f + %0.2f tip + %0.2f tax",
            tipCalc.calcTotalAmount(),
            tipCalc.calcShouldFeelLike(),
            tipCalc.calcShouldTipLike(),
            tipCalc.calcShouldTaxLike())
    }

    func resetUI(homeCountry:country, foreignCountry:country) {
        tipCalc.foreignTaxRate =  foreignCountry.taxRate
        tipCalc.foreignTipRate = foreignCountry.tipRate
        tipCalc.exchangeRate =  foreignCountry.exchangeRate / homeCountry.exchangeRate
        tipCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
        tipCalc.homeTaxRate =  homeCountry.taxRate
        tipCalc.homeTipRate =  homeCountry.tipRate
        homeCostField.text = NSString (format: "%.2f", tipCalc.calcShouldFeelLike())
        homeCostLabel.text = String(format: "%0.2f total = %0.2f + %0.2f tip + %0.2f tax",
            tipCalc.calcTotalAmount(),
            tipCalc.calcShouldFeelLike(),
            tipCalc.calcShouldTipLike(),
            tipCalc.calcShouldTaxLike())
        initUI()
    }
}

