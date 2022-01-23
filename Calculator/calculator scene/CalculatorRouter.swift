//
//  CalculatorRouter.swift
//  Calculator
//
//  Created by SmartPan on 1/23/22.
//

import UIKit
protocol CalculatorRouterProtocol {
    func start(delegate: CalculatorDelegate)
}

class CalculatorRouter: CalculatorRouterProtocol {
    private var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start(delegate: CalculatorDelegate) {
        let interactor = CalculatorInteractor()
        let presenter = CalculatorPresenter(operationHandler: OperationHandler(), interactor: interactor, router: self)
        let calculatorVC = CalculatorViewController.init(presenter: presenter)
        presenter.viewController = calculatorVC
        calculatorVC.tabBarItem = UITabBarItem(title: "Calculator", image: nil, tag: 0)
        interactor.presenter = presenter
        presenter.setEgpTextValueDelegate = delegate
        tabBarController.viewControllers = [calculatorVC]
    }
}
