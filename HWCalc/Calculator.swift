//
//  Calculator.swift
//  HWCalc
//
//  Created by Alex Votry on 3/8/17.
//  Copyright © 2017 Alex Votry. All rights reserved.
//

import Foundation

struct Calculator {

    private var displayNum: Double?

    enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }

    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi),
        "√" : Operation.unaryOperation(sqrt),
        "sin": Operation.unaryOperation(sin),
        "cos": Operation.unaryOperation(cos),
        "±" : Operation.unaryOperation({ -$0}),
        "×" : Operation.binaryOperation({$0 * $1}),
        "÷" : Operation.binaryOperation({$0 / $1}),
        "−" : Operation.binaryOperation({$0 - $1}),
        "+" : Operation.binaryOperation({$0 + $1}),
        "=" : Operation.equals
        ]

    mutating func performOp(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant (let value):
                displayNum = value
            case .unaryOperation(let thisFunc):
                if displayNum != nil {
                    displayNum = thisFunc(displayNum!)
                }
            case .binaryOperation(let thisFunc):
                if displayNum != nil {
                    firstNum = saveFirstNumWithOperand(function: thisFunc, first: displayNum!)
                    displayNum = nil
                }
            case .equals:
                finishOperation()
            }
        }
    }
    private mutating func finishOperation() {
        if firstNum != nil && displayNum != nil {
            displayNum = firstNum!.perform(displayNum!)
            firstNum = nil
        }
    }
    private var firstNum: saveFirstNumWithOperand?
    
    private struct saveFirstNumWithOperand {
        let function: (Double, Double) -> Double
        let first: Double
        
        func perform(_ second: Double) -> Double {
            return function(first, second)
        }
    }
    
    mutating func setNum(_ displayValue: Double) {
        displayNum = displayValue
    }
    
    var result : Double? {
        get {
            return displayNum
        }
    }
}
