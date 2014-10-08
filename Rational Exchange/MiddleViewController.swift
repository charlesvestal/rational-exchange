//
//  MiddleViewController.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 10/8/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation

class CVMiddleViewController: UIViewController {
    
    @IBOutlet weak var foreignCostField: UITextField!
    @IBOutlet weak var gotoTopButton: UIButton!
    @IBOutlet weak var gotoBottomButton: UIButton!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    keyboardSetup()
    roundTheButtons()
    }
    
    
    
    // round the buttons 
    
    func roundTheButtons() {
        gotoTopButton.layer.cornerRadius = 0.5 * gotoTopButton.bounds.size.width
        gotoTopButton.layer.masksToBounds = true
        
        gotoBottomButton.layer.cornerRadius = 0.5 * gotoBottomButton.bounds.size.width
        gotoBottomButton.layer.masksToBounds = true
    }
    // end rounding the buttons
    
    // adding keyboard Done button to decimal pad
    func keyboardSetup() {
        let keyboardDoneButtonView:UIToolbar = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        
        let doneButton:UIBarButtonItem = UIBarButtonItem(title: "Done",
            style: .Done,
            target: self,
            action: "doneClicked")
        
        keyboardDoneButtonView.setItems([doneButton], animated:false)

        
        foreignCostField.inputAccessoryView = keyboardDoneButtonView
    }
    
    func doneClicked()
    {
        self.view.endEditing(true)
    }
    // end keyboard done button implementation
}