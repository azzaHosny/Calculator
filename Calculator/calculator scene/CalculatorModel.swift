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
    var firstOperand: Double
    var secondOperand: Double
    var operationSign: OperationsType
}
