//
//  CurrencyConverterViewController.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import UIKit

protocol CurrencyConverterDelegate: AnyObject {
    func convertButtonTapped(result: Int)
}

class CurrencyConverterViewController: UIViewController {
    
    private var intialResult: Int
    
    weak var currencyDelegate: CurrencyConverterDelegate?
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var egpTextField: UITextField!
    
    @IBAction func convertIsPressed(_ sender: Any) {
        if currencyDelegate != nil {
            currencyDelegate?.convertButtonTapped(result: Int(egpTextField.text ?? "0") ?? 0)
        }
    }
    
    init(intialResult: Int) {
        self.intialResult = intialResult
        super.init(nibName: "CurrencyConverterViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
 
    func setup() {
        egpTextField.text = "\(intialResult)"
    }
    
    func setIntialResultValue(value: Int) {
        intialResult = value
        egpTextField.text = "\(intialResult)"
    }
    
}
