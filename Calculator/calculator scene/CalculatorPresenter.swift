//
//  CalculatorPresenter.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import Foundation

protocol CalculatorPresenterProtocol {
    func executeOperation(operation: Operation)
    func undo()
    func redo()
}

class CalculatorPresenter: CalculatorPresenterProtocol {
    
    weak var viewController: CalculatorViewProtocol?
    var undoOperations: [Operation] = []
    var redoOperations: [Operation] = []
    var calculatedOperations: [Operation] = []
    
    func executeOperation(operation: Operation) {
        var result = operation.firstOperand
        switch operation.operationSign {
        case .divid:
            result = result / operation.secondOperand
        case .minus:
            result = result - operation.secondOperand
        case .plus:
            result = result + operation.secondOperand

        case .multiply:
            result = result * operation.secondOperand
        }
        var executedOperation = operation
        executedOperation.firstOperand = result
        viewController?.operationExecuted(operation: executedOperation)
    }
    
    func undo() {
        
    }
    
    func redo() {
        
    }
}
