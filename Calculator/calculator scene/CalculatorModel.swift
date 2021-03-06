//
//  CalculatorModel.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import Foundation
enum OperationsType: String {
    case plus = "+"
    case minus = "-"
    case multiply = "*"
    case divid = "/"
}

struct Operation {
    var firstOperand: Int
    var secondOperand: Int
    var operationSign: OperationsType
    var concatentedOpertionAndSecondOperand: String {
        return "\(operationSign.rawValue) \(secondOperand) "
    }
}
