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

class CalculatorViewController: UIViewController {
    
    var presenter: CalculatorPresenterProtocol
    var calculatedOperations: [Operation] = []
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var secondOperandTextField: UITextField!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var operationsCollectionView: UICollectionView!
    
    @IBAction func undoIsPressed(_ sender: Any) {
        presenter.undo()
    }
    
    @IBAction func redoIsPressed(_ sender: Any) {
        presenter.redo()
    }
    
    @IBAction func plusIsPressed(_ sender: Any) {
        presenter.setOperationType(operationType: .plus)
    }
    
    @IBAction func minusIsPressed(_ sender: Any) {
        presenter.setOperationType(operationType: .minus)
    }
    
    @IBAction func DividIsPressed(_ sender: Any) {
        presenter.setOperationType(operationType: .divid)
    }
    
    @IBAction func multiplyIsPressed(_ sender: Any) {
        presenter.setOperationType(operationType: .multiply)
    }
    
    @IBAction func equalIsPressed(_ sender: Any) {
        if let secondOperandText = secondOperandTextField.text, let secondOperand = Double(secondOperandText) {
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
}

extension CalculatorViewController: CalculatorViewProtocol  {
    func operationExecuted(operations: [Operation]) {
        calculatedOperations = operations
        resultLabel.text = "Result = \(operations.last?.firstOperand)"
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
        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
       let width: CGFloat = floor(adjustedWidth / columns)
        return CGSize(width: width, height: 50)
    }
}

