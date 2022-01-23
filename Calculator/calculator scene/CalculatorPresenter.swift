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

protocol CalculatorPresenterDelegate: AnyObject {
    
}

class CalculatorPresenter: CalculatorPresenterProtocol {
    weak var setEgpTextValueDelegate: CalculatorDelegate?
    private var operationHandler: OperationHandlerProtocol
    private var router: CalculatorRouter
    private var interactor: CalculatorInteractorProtocol
    var currentIndex: Int = 0
    var currentOperationType: OperationsType?
    var result: Int = 0
    weak var viewController: CalculatorViewProtocol?
    var calculatedOperations: [Operation] = []
    
    init(operationHandler: OperationHandlerProtocol, interactor: CalculatorInteractorProtocol, router: CalculatorRouter) {
        self.operationHandler = operationHandler
        self.interactor = interactor
        self.router = router
    }
    
    func setOperationType(operationType: OperationsType) {
        self.currentOperationType = operationType
        viewController?.enableSecondOperandTextFieldAndResetText(isEnabled: self.currentOperationType != nil)
    }
    
    func executeOperation(secondOperand: Int) {
        handelOperationType(secondOperand: secondOperand)
    }
    
    private func handelOperationType(secondOperand: Int) {
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
    
    private func refreshUndoAndRedoButtons() {
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
            currentOperationType = operation.operationSign
            result = operation.firstOperand
            handelOperationType(secondOperand: operation.secondOperand)
        }
    }
    
}

extension CalculatorPresenter: CalculatorPresenterDelegate {
    
}
