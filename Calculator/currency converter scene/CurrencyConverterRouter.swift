//
//  CurrencyConverterRouter.swift
//  Calculator
//
//  Created by SmartPan on 1/23/22.
//

import UIKit
protocol CurrencyConverterRouterProtocol {
    func start(currencyDelegate: CurrencyConverterDelegate)
}
class CurrencyConverterRouter: CurrencyConverterRouterProtocol {
    private var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start(currencyDelegate: CurrencyConverterDelegate) {
        let dataSource = MockCurrencyConverterDatasource()
        let interactor = CurrencyConverterInteractor(datasource: dataSource)
        let presenter =  CurrencyConverterPresenter(interactor: interactor, router: self)
        let currencyTabVC = CurrencyConverterViewController.init(intialResult: 0, presenter: presenter)
        presenter.viewController = currencyTabVC
        interactor.presenter = presenter
        currencyTabVC.tabBarItem = UITabBarItem(title: "Curreny Converter", image: nil, tag: 1)
        presenter.currencyDelegate = currencyDelegate
        tabBarController.viewControllers?.append(currencyTabVC)
    }

}
