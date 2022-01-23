//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import UIKit

protocol CalculatorViewProtocol: AnyObject {
    func operationExecuted(operations: [Operation])
    func enableSecondOperandTextFieldAndResetText(isEnabled: Bool)
    func enableOrDisableRedoButton(isEnabled: Bool)
    func enableOrDisableUndoButton(isEnabled: Bool)
}
protocol CalculatorDelegate: AnyObject {
    func setEgpTextValue(result: Int)
}

class CalculatorViewController: UIViewController {
    weak var setEgpTextValueDelegate: CalculatorDelegate?
    var presenter: CalculatorPresenterProtocol
    var calculatedOperations: [Operation] = []
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var multiplyButton: UIButton!
    @IBOutlet private weak var divisionButton: UIButton!
    private var operationsButtons: [UIButton]{
        return [plusButton, minusButton, multiplyButton, divisionButton]
    }
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var secondOperandTextField: UITextField!
    @IBOutlet private weak var undoButton: UIButton!
    @IBOutlet private weak var redoButton: UIButton!
    @IBOutlet private weak var operationsCollectionView: UICollectionView!
    
    @IBAction func undoIsPressed(_ sender: Any) {
        presenter.undo()
    }
    
    @IBAction func redoIsPressed(_ sender: Any) {
        presenter.redo()
    }
    
    private func enableOperationButton(button: UIButton) {
        operationsButtons.forEach { $0.isSelected = false }
        button.isSelected = true
    }
    
    @IBAction func plusIsPressed(_ sender: UIButton) {
        presenter.setOperationType(operationType: .plus)
        enableOperationButton(button: sender)
    }
    
    @IBAction func minusIsPressed(_ sender: UIButton) {
        presenter.setOperationType(operationType: .minus)
        enableOperationButton(button: sender)

    }
    
    @IBAction func DividIsPressed(_ sender: UIButton) {
        presenter.setOperationType(operationType: .divid)
        enableOperationButton(button: sender)

    }
    
    @IBAction func multiplyIsPressed(_ sender: UIButton) {
        presenter.setOperationType(operationType: .multiply)
        enableOperationButton(button: sender)

    }
    
    @IBAction func equalIsPressed(_ sender: UIButton) {
        if let secondOperandText = secondOperandTextField.text, let secondOperand = Int(secondOperandText) {
            presenter.executeOperation(secondOperand: secondOperand)
        }
    }
    
    init(presenter: CalculatorPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "CalculatorViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
   
    func setup() {
        registerCell()
        setCollectionViewDelegates()
        secondOperandTextField.isUserInteractionEnabled = false
        undoButton.isEnabled = false
        redoButton.isEnabled = false

    }
    
    func registerCell() {
        operationsCollectionView.register(UINib(nibName: "calculatorOperationCell", bundle: nil), forCellWithReuseIdentifier: "calculatorOperationCell")
    }
 
    func setCollectionViewDelegates() {
        operationsCollectionView.delegate = self
        operationsCollectionView.dataSource = self
    }
    
    func enableSecondOperandTextFieldAndResetText(isEnabled: Bool) {
        secondOperandTextField.text = ""
        secondOperandTextField.isUserInteractionEnabled = isEnabled
    }
    
    func enableOrDisableUndoButton(isEnabled: Bool){
        undoButton.isEnabled = isEnabled
    }
    
    func enableOrDisableRedoButton(isEnabled: Bool){
        redoButton.isEnabled = isEnabled
    }
     
    func changeResultValue(result: Int) {
        if isViewLoaded {
            presenter.addNewOperationAfterCovertCurrency(resultValue: result)
        }
    }
    
    func getOperationsResult() {
        setEgpTextValueDelegate?.setEgpTextValue(result: calculatedOperations.last?.firstOperand ?? 0)
    }
}

extension CalculatorViewController: CalculatorViewProtocol  {
    func operationExecuted(operations: [Operation]) {
        calculatedOperations = operations
        resultLabel.text = "Result = \(operations.last?.firstOperand ?? 0)"
        operationsButtons.forEach { $0.isSelected = false }
        operationsCollectionView.reloadData()
    }
}

extension CalculatorViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calculatedOperations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calculatorOperationCell", for: indexPath) as! calculatorOperationCell
        cell.configure(operation: calculatedOperations[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:  calculatedOperations[indexPath.row].concatentedOpertionAndSecondOperand.getSizeOfString().width + 10 , height: 50)
    }
}

extension String {
    func getSizeOfString( font: UIFont = .systemFont(ofSize: 17)) -> CGSize {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute) 
       return size
    }
}
