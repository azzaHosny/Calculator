//
//  CurrencyConverterDatasource.swift
//  Calculator
//
//  Created by SmartPan on 1/23/22.
//

import Foundation

protocol CurrencyConverterDatasourceProtocol {
    func getCurrencyRate(completion: (Result<Double, Error>) -> Void)
}
class MockCurrencyConverterDatasource: CurrencyConverterDatasourceProtocol {
    func getCurrencyRate(completion: (Result<Double, Error>) -> Void) {
        completion(.success(0.16))
    }
}
