//
//  CustomeTabeViewController.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import UIKit

class CustomeTabViewController: UITabBarController, CurrencyConverterDelegate {
    
    private var calculatorVC: CalculatorViewController? {
        return viewControllers?.first(where: {$0 is CalculatorViewController}) as? CalculatorViewController
    }
    
    func convertButtonTapped(result: Int) {
        calculatorVC?.changeResultValue(result: result)
    }
    
   func start() {
        let presenter = CalculatorPresenter(operationHandler: OperationHandler())
        let calculatorVC = CalculatorViewController.init(presenter: presenter)
        calculatorVC.tabBarItem = UITabBarItem(title: "Calculator", image: nil, tag: 0)
        presenter.viewController = calculatorVC
        let currencyTabVC = CurrencyConverterViewController.init(intialResult: 0)
        currencyTabVC.currencyDelegate = self
        currencyTabVC.tabBarItem = UITabBarItem(title: "Curreny Converter", image: nil, tag: 1)
        self.viewControllers = [calculatorVC, currencyTabVC]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    }

}
