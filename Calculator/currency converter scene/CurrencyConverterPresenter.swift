//
//  CurrencyConverterPresenter.swift
//  Calculator
//
//  Created by SmartPan on 1/23/22.
//

import Foundation
protocol CurrencyConverterPresenterProtocol: AnyObject {
    func convertEGPValueToUSD(egpValue: Int)
}
protocol CurrencyConverterPresenterDelegate: AnyObject {
    func handelSuccessRate(rate: Double)
    func handelFailure(error: Error)

}
class CurrencyConverterPresenter: CurrencyConverterPresenterProtocol {
    weak var currencyDelegate: CurrencyConverterDelegate?
    private var egpValue: Int = 0
    private var interactor: CurrencyConverterInteractorProtocol
    private var router: CurrencyConverterRouterProtocol
    weak var viewController: CurrencyConverterViewProtocol?
    
    init(interactor: CurrencyConverterInteractorProtocol, router: CurrencyConverterRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func convertEGPValueToUSD(egpValue: Int) {
        self.egpValue = egpValue
        interactor.convertEGPValueToUSD(egpValue: egpValue)
    }

}
extension CurrencyConverterPresenter: CurrencyConverterPresenterDelegate {
    
    func handelSuccessRate(rate: Double) {
        viewController?.updateUSDTextValue(usdValue: (rate * Double(egpValue)))
        currencyDelegate?.convertButtonTapped(result: egpValue)
    }
    
    func handelFailure(error: Error) {
        viewController?.handleGetRateFailure(error: error)
    }
    
}
