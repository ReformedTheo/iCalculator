//
//  ViewModel.swift
//  iCalculator
//
//  Created by Theo Lopes on 13/11/2024.
//

import SwiftUI

class CalculatorViewModel: ObservableObject {
    @Published var displayText: String = "0"
    private var currentOperation: CalculatorButton?
    private var firstOperand: Double?
    
    func handleButtonPress(_ button: CalculatorButton) {
        switch button {
        case .clear:
            handleClear()
        case .equals:
            calculateResult()
        case .add, .subtract, .multiply, .divide:
            handleOperation(button)
        case .negative:
            toggleNegative()
        case .percent:
            calculatePercentage()
        default:
            handleNumberInput(button.title)
        }
    }
    
    private func handleNumberInput(_ number: String) {
        if displayText == "0" {
            displayText = number
        } else {
            displayText += number
        }
    }
    
    private func handleOperation(_ operation: CalculatorButton) {
        firstOperand = Double(displayText)
        currentOperation = operation
        displayText = "0"
    }
    
    private func calculateResult() {
        guard let firstOperand = firstOperand,
              let currentOperation = currentOperation,
              let secondOperand = Double(displayText) else { return }
        
        var result: Double?
        switch currentOperation {
        case .add:
            result = firstOperand + secondOperand
        case .subtract:
            result = firstOperand - secondOperand
        case .multiply:
            result = firstOperand * secondOperand
        case .divide:
            result = secondOperand != 0 ? firstOperand / secondOperand : nil
        default:
            break
        }
        
        if let result = result {
            displayText = String(result)
        }
    }
    
    private func handleClear() {
        displayText = "0"
        firstOperand = nil
        currentOperation = nil
    }
    
    private func toggleNegative() {
        if let value = Double(displayText) {
            displayText = String(value * -1)
        }
    }
    
    private func calculatePercentage() {
        if let value = Double(displayText) {
            displayText = String(value / 100)
        }
    }
}

