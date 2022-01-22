//
//  CustomeTabeViewController.swift
//  Calculator
//
//  Created by SmartPan on 1/22/22.
//

import UIKit

class CustomeTabViewController: UITabBarController, CurrencyConverterDelegate {
    private var calculatorVC: CalculatorViewController? {
        return viewControllers?.first(where: {$0 is CalculatorViewController}) as? CalculatorViewController
    }
    
    func convertButtonTapped(result: Int) {
        calculatorVC?.changeResultValue(result: result)
    }

}
