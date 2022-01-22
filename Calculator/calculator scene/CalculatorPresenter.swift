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
    var operationType: OperationsType?
    var result: Double = 0
    weak var viewController: CalculatorViewProtocol?
    var undoOperations: [Operation] = []
    var redoOperations: [Operation] = []
    var calculatedOperations: [Operation] = []
    
    func setOperationType(operationType: OperationsType) {
        self.operationType = operationType
        viewController?.enableSecondOperandTextFieldAndResetText(isEnabled: self.operationType != nil)
    }

    func executeOperation(secondOperand: Double) {
        guard let operationType = operationType else { // error operation must be selected first
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
        viewController?.operationExecuted(operation: executedOperation)
    }
    
    func undo() {
        
    }
    
    func redo() {
        
    }
}
