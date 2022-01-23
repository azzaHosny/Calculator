//
//  CustomeTabeViewController.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import UIKit

class CustomeTabViewController: UITabBarController, CurrencyConverterDelegate, CalculatorDelegate, UITabBarControllerDelegate {

    private var calculatorVC: CalculatorViewController? {
        return viewControllers?.first(where: {$0 is CalculatorViewController}) as? CalculatorViewController
    }
    
    private var currencyConverter: CurrencyConverterViewController? {
        return viewControllers?.last(where: {$0 is CurrencyConverterViewController}) as? CurrencyConverterViewController
    }
    
    func convertButtonTapped(result: Int) {
        calculatorVC?.changeResultValue(result: result)
    }
    
    func setEgpTextValue(result: Int) {
        currencyConverter?.setIntialResultValue(value: result)
    }
    
   func start() {
        self.viewControllers = []
        CalculatorRouter.init(tabBarController: self).start(delegate: self)
        CurrencyConverterRouter.init(tabBarController: self).start(currencyDelegate: self)
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if (viewController is CurrencyConverterViewController) {
            calculatorVC?.getOperationsResult()
        }
    }

}
