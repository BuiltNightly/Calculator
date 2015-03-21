//
//  ViewController.swift
//  Calculator
//
//  Created by Built Nightly on 1/29/15.
//  Copyright (c) 2015 Built Nightly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTypingNumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if digit == "." && display.text!.rangeOfString(".") != nil {
            println("We already have a decimal silly...")
            println("This ain\'t no ip address!")
            return
        }
        
        if userIsInTheMiddleOfTypingNumber {
            display.text = display.text! + digit
        }
        else {
            if digit == "." && display.text! == "0"{
                //We aren't neanderthals here, right?
                display.text = "0" + digit
            }
            else{
                display.text = digit
            }
            userIsInTheMiddleOfTypingNumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber {
            enter()
        }
        
        switch operation {
            case "×": performOperation { $0 * $1 }
            case "÷": performOperation { $1 / $0 }
            case "+": performOperation { $0 + $1 }
            case "−": performOperation { $1 - $0 }
            case "√": performOperation { sqrt($0)}
            case "sin" : performOperation  { sin($0) }
            case "cos" : performOperation { cos($0) }
            case "π" : inputConstant(operation)
            
            default:break
        }
    }
    
    func inputConstant(operation:String){
        if operation == "π" {
            displayValue = M_PI
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
    }

    func performOperation(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingNumber = false
        }
    }
}

