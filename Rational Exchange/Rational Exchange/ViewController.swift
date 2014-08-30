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
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var foreignPicker: UIPickerView!
    @IBOutlet weak var homePicker: UIPickerView!
    
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
        foreignCostField.text = String(format: "%0.2f", tipCalc.foreignTheyWant)
        homeCostField.text = String(format: "%0.2f", tipCalc.calcShouldFeelLike())
        homeCostLabel.text = String(format: "%0.2f total = %0.2f + %0.2f tip + %0.2f tax",
            tipCalc.calcTotalAmount(),
            tipCalc.calcShouldFeelLike(),
            tipCalc.calcShouldTipLike(),
            tipCalc.calcShouldTaxLike())
       
        
    }

      func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int
      {
        return 1
    }
    
    let pickerData = ["Norway", "USA", "Germany"]
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int
    {
    return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return pickerData[row]
    }
    
    func updateUI()   {
        tipCalc.foreignTheyWant = Double((foreignCostField.text as NSString).doubleValue)
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

