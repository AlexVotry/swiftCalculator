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
    private var secondNum = ""
    private var stillFirst = true
    private var mem: String?
    
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
        displayNumber = nil
        stillFirst = false
        
        switch operand {
        case "π":
            equation = (equation == nil ? operand : equation)
            secondNum = (secondNum == "" && equation != "π" ? operand : secondNum)
            return equation! + secondNum + " ..."
        case "√", "sin", "cos":
            if equation != nil {
                let sqrt = (mem != nil ? mem! : equation!)
                let finished = operand + "(" + sqrt + ") = "
                reset(nil)
                return finished
            } else {
                return "ready"
            }
        case "=":
            let finished = equation! + secondNum
            reset(finished)
            return finished + "="
        case "m", "mc":
            return equation! + "(m)"
        case "C":
            reset(nil)
            return "ready"
        default:
            if equation != nil {
                equation!.append(operand)
                stillFirst = false
                return equation! + " ..."
            } else {
                return "ready"
            }
        }
    }
    private mutating func reset(_ finished: String? ) {
        mem = (secondNum == "" ? equation : finished)
        equation = ""
        secondNum = ""
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
        return equation! + secondNum + " ..."
    }
    
}
