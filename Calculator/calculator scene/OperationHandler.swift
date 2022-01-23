//
//  OperationHandeler.swift
//  Calculator
//
//  Created by azah on 1/23/22.
//

import Foundation
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
