//
//  DisplayBtn.swift
//  HWCalc
//
//  Created by Alex Votry on 3/11/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import Foundation

struct DisplayBtn {
    
    private var numDecimal = 0
    private var displayNumber: String?
    private var equation: String?
    private var secondNum: String!
    private var stillFirst = true
    
    private mutating func noDecimal(_ decimal: String) -> Bool {
        if decimal == "." {
            numDecimal += 1
        }
        if numDecimal > 1 {
            return false
        }
        return true
    }
    
    mutating func getNum(_ number: String) -> String {
        if displayNumber != nil {
            if noDecimal(number) {
                displayNumber!.append(number)
            } else {
                numDecimal = 1
                return displayNumber!
            }
        } else {
            displayNumber = number
            numDecimal = 0
        }
        return displayNumber!
    }
    
    mutating func writeEquation(_ operand: String) -> String {
        equation = (equation == nil ? operand : equation)
        displayNumber = nil
        stillFirst = false
        
        switch operand {
        case "π":
            return equation! + " ..."
        case "√", "sin", "cos":
            let finished = operand + "(" + equation! + ") = "
            reset()
            return finished
        case "=":
            let finished = equation! + secondNum + "="
            reset()
            print("equals: \(stillFirst)")
            return finished
        case "m", "mc":
            return equation! + "(m)"
        case "C":
            reset()
            return "ready"
        default:
            equation!.append(operand)
            stillFirst = false
            return equation! + " ..."
        }
    }
    private mutating func reset() {
        equation = nil
        secondNum = nil
        stillFirst = true
    }

    mutating func writeDisplay(_ number: String?) -> String {
        if equation != nil {
            if stillFirst {
                equation! = displayNumber!
                secondNum = ""
            } else {
                secondNum = displayNumber!
            }
        } else {
            equation = number!
            secondNum = ""
        }
        return equation! + secondNum! + " ..."
    }
    
}
