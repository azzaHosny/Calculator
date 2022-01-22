//
//  CalculatorPresenter.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import Foundation

protocol CalculatorPresenterProtocol {
    func setOperationType(operationType: OperationsType)
    func executeOperation(secondOperand: Double)
    func undo()
    func redo()
}

class CalculatorPresenter: CalculatorPresenterProtocol {
    var currentIndex: Int = 0
    var currentOperationType: OperationsType?
    var result: Double = 0
    weak var viewController: CalculatorViewProtocol?
    var undoOperations: [Operation] = []
    var redoOperations: [Operation] = []
    var calculatedOperations: [Operation] = []
    
    func setOperationType(operationType: OperationsType) {
        self.currentOperationType = operationType
        viewController?.enableSecondOperandTextFieldAndResetText(isEnabled: self.currentOperationType != nil)
    }
    
    func executeOperation(secondOperand: Double) {
        guard let operationType = currentOperationType else { // error operation must be selected first
            return }
        switch operationType {
        case .divid:
            result = result / secondOperand
        case .minus:
            result = result - secondOperand
        case .plus:
            result = result + secondOperand
        case .multiply:
            result = result * secondOperand
        }
        let executedOperation = Operation(firstOperand: result, secondOperand: secondOperand, operationSign: operationType)
        calculatedOperations.append(executedOperation)
        currentIndex = calculatedOperations.count - 1
        viewController?.operationExecuted(operations: Array(calculatedOperations[0...currentIndex]))
        currentOperationType = nil
        
        viewController?.enableSecondOperandTextFieldAndResetText(isEnabled: false)
        refreshUndoAndRedoButtons()
        
    }
    
    func refreshUndoAndRedoButtons() {
        viewController?.enableOrDisableRedoButton(isEnabled: currentIndex < calculatedOperations.count - 1 )
        viewController?.enableOrDisableUndoButton(isEnabled: currentIndex > 0)
    }
    
    func undo() {
        guard currentIndex > 0 else {
            // show error
            return
        }
        currentIndex -= 1
        viewController?.operationExecuted(operations: Array(calculatedOperations[0...currentIndex]))
        refreshUndoAndRedoButtons()
    }
    
    func redo() {
        guard currentIndex < calculatedOperations.count - 1 else {
            // show error
            return
        }
        currentIndex += 1
        viewController?.operationExecuted(operations: Array(calculatedOperations[0...currentIndex]))
        refreshUndoAndRedoButtons()
    }
}
