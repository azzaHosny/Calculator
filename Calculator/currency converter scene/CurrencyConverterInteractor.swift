//
//  CurrencyConverterInteractor.swift
//  Calculator
//
//  Created by SmartPan on 1/23/22.
//

import Foundation
protocol CurrencyConverterInteractorProtocol {
   func convertEGPValueToUSD(egpValue: Int)
}

class CurrencyConverterInteractor: CurrencyConverterInteractorProtocol {
    var datasource: CurrencyConverterDatasourceProtocol
    weak var presenter: CurrencyConverterPresenterDelegate?
    init(datasource: CurrencyConverterDatasourceProtocol){
        self.datasource = datasource
    }
    
    func convertEGPValueToUSD(egpValue: Int) {
        datasource.getCurrencyRate { (result) in
            switch result {
            case .failure(let error):
                presenter?.handelFailure(error: error)
            case .success(let rate):
                presenter?.handelSuccessRate(rate: rate)
            }
        }
    }
    
}
