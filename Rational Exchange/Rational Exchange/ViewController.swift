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
    
    @IBOutlet weak var calculateButton: UIButton!
    
    @IBOutlet weak var homeCostField: UITextField!
    @IBOutlet weak var homeCostLabel: UILabel!
    
    @IBOutlet weak var homeTaxField: UITextField!
    @IBOutlet weak var homeTipField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func calculateTapped(sender : AnyObject) {
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
    
    @IBAction func foreignTaxFieldChanged(sender : AnyObject) {
    }
    
    @IBAction func foreignTipFieldChanged(sender : AnyObject) {
    }
    
    @IBAction func foreignExchangeFieldChanged(sender : AnyObject) {
    }
    
    @IBAction func viewTapped(sender : AnyObject) {
        foreignTaxField.resignFirstResponder()
        foreignExchangeField.resignFirstResponder()
        foreignTipField.resignFirstResponder()
        foreignCostField.resignFirstResponder()
        homeTaxField.resignFirstResponder()
        homeTipField.resignFirstResponder()
        
    }
    
    let tipCalc = TipCalculatorModel(foreignTheyWant: 96,
                                    exchangeRate: 6.0,
                                    foreignTaxRate: 0.0,
                                    foreignTipRate: 0.0,
                                    homeTaxRate: 8.25,
                                    homeTipRate: 20)
    
    func refreshUI() {
        foreignTaxField.text = String(format: "%0.2f", tipCalc.foreignTaxRate)
        foreignTipField.text = String(format: "%0.2f", tipCalc.foreignTipRate)
        foreignExchangeField.text = String(format: "%0.2f", tipCalc.exchangeRate)
        foreignCostField.text = String(format: "%0.2f", tipCalc.foreignTheyWant)
        homeCostField.text = String(format: "%0.2f", tipCalc.calcShouldFeelLike()) // how to get this? convert to functions?
        homeCostLabel.text = String(format: "%0.2f total = %0.2f + %0.2f tip + %0.2f tax",
            tipCalc.calcTotalAmount(),
            tipCalc.calcShouldFeelLike(),
            tipCalc.calcShouldTipLike(),
            tipCalc.calcShouldTaxLike())
        homeTaxField.text = String(format: "%0.4f", tipCalc.homeTaxRate)
        homeTipField.text = String(format: "%0.2f", tipCalc.homeTipRate)
    }

}

