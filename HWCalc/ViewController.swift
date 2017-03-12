//
//  ViewController.swift
//  HWCalc
//
//  Created by Alex Votry on 3/8/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var topDisplay: UILabel!
    private var calculator = Calculator()
    private var recentNumber = DisplayBtn()
    
    var isTyping = false
    
    var displayValue : Double {
        get {
            return Double(display.text!)!
        }
        set {
            return display.text = String(newValue)
        }
    }
    
    @IBAction func numberBtn(_ sender: UIButton) {
        display.text! = recentNumber.getNum(sender.currentTitle!)
        topDisplay.text! = recentNumber.writeDisplay(sender.currentTitle!)
        isTyping = true
    }
    
    @IBAction func operators(_ sender: UIButton) {
        if isTyping {
            calculator.setNum(displayValue) //sends number to use to calculator
            isTyping = false
            topDisplay.text! = recentNumber.writeEquation(sender.currentTitle!)
        }
        if let mathFunction = sender.currentTitle {
            calculator.performOp(mathFunction)
        }
        if let result = calculator.result {
            displayValue = result
        }
    }
    
}

