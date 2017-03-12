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
    
    mutating func noDecimal(_ decimal: String) -> Bool {
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
        if operand == "=" {
            let fininshed = equation! + secondNum + "="
            equation = nil
            secondNum = nil
            stillFirst = true
            return fininshed
        } else {
            equation!.append(operand)
            return equation! + "..."
        }
    }
    
    mutating func writeDisplay(_ number: String) -> String {
        if equation != nil {
            if stillFirst {
                equation! = displayNumber!
                secondNum = ""
            } else {
                secondNum = displayNumber!
            }
        } else {
            equation = number
            secondNum = ""
        }
        return equation! + secondNum! + "..."
    }
    
}
