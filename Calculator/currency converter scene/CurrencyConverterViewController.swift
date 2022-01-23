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
protocol CurrencyConverterViewProtocol: AnyObject {
    func updateUSDTextValue(usdValue: Double)
    func handleGetRateFailure(error: Error)
}

class CurrencyConverterViewController: UIViewController {
    
    private var intialResult: Int
    private var presenter: CurrencyConverterPresenterProtocol
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var egpTextField: UITextField!
    
    @IBAction func convertIsPressed(_ sender: Any) {
        presenter.convertEGPValueToUSD(egpValue: Int(egpTextField.text ?? "0") ?? 0)
    }
    
    init(intialResult: Int, presenter: CurrencyConverterPresenterProtocol) {
        self.presenter = presenter
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

extension CurrencyConverterViewController: CurrencyConverterViewProtocol {
    func updateUSDTextValue(usdValue: Double) {
        usdLabel.text = "\(usdValue)"
    }
    
    func handleGetRateFailure(error: Error) {
        // handel error
    }
    
    
}
