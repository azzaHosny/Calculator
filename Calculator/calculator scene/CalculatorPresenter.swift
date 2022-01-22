//
//  CalculatorPresenter.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import Foundation

protocol CalculatorPresenterProtocol {
    func setOperationType(operationType: OperationsType)
    func executeOperation(secondOperand: Int)
    func undo()
    func redo()
    func addNewOperationAfterCovertCurrency(resultValue: Int)
}

class CalculatorPresenter: CalculatorPresenterProtocol {
    private var operationHandler: OperationHandlerProtocol
    var currentIndex: Int = 0
    var currentOperationType: OperationsType?
    var result: Int = 0
    weak var viewController: CalculatorViewProtocol?
    var undoOperations: [Operation] = []
    var redoOperations: [Operation] = []
    var calculatedOperations: [Operation] = []
    
    init(operationHandler: OperationHandlerProtocol) {
        self.operationHandler = operationHandler
    }
    
    func setOperationType(operationType: OperationsType) {
        self.currentOperationType = operationType
        viewController?.enableSecondOperandTextFieldAndResetText(isEnabled: self.currentOperationType != nil)
    }
    
    func executeOperation(secondOperand: Int) {
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
    
    func addNewOperationAfterCovertCurrency(resultValue: Int) {
        if resultValue != result {
            let operation = operationHandler.getOperation(calculatorResult: result, converterResult: resultValue)
            result = operation.firstOperand
            calculatedOperations.append(operation)
            currentIndex = calculatedOperations.count - 1
            viewController?.operationExecuted(operations: Array(calculatedOperations[0...currentIndex]))
            currentOperationType = nil
            viewController?.enableSecondOperandTextFieldAndResetText(isEnabled: false)
            refreshUndoAndRedoButtons()
            
        }
    }
}
protocol OperationHandlerProtocol {
    func getOperation(calculatorResult: Int, converterResult: Int) -> Operation
}
class OperationHandler: OperationHandlerProtocol {
    
    func getOperation(calculatorResult: Int, converterResult: Int) -> Operation {
        if calculatorResult > converterResult {
            if calculatorResult % converterResult == 0 {
                return Operation(firstOperand: calculatorResult, secondOperand: (calculatorResult / converterResult), operationSign: .divid)
            } else {
                return Operation(firstOperand: calculatorResult, secondOperand: (calculatorResult - converterResult), operationSign: .minus)
            }
        } else {
            if converterResult % calculatorResult == 0 {
                return Operation(firstOperand: calculatorResult, secondOperand: (converterResult / calculatorResult), operationSign: .multiply)
            } else {
                return Operation(firstOperand: calculatorResult, secondOperand: (converterResult - calculatorResult ), operationSign: .plus)
            }
        }
    }

}
