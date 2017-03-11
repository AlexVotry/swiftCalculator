//
//  DisplayBtn.swift
//  HWCalc
//
//  Created by Alex Votry on 3/11/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import Foundation

struct DisplayBtn {

    var numDecimal = 0
    var displayNumber: String?

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



}
