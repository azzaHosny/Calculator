//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import UIKit

protocol CalculatorViewProtocol: AnyObject {
    func operationExecuted(operation: Operation)
}

class CalculatorViewController: UIViewController {
    
    var presenter: CalculatorPresenterProtocol?
    var calculatedOperations: [Operation] = []
    var operationType: OperationsType?
    var secondOperand: Double?
    var result: Double = 0
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var secondOperandTextField: UITextField!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    @IBOutlet weak var operationsCollectionView: UICollectionView!
    
    @IBAction func undoIsPressed(_ sender: Any) {
    }
    
    @IBAction func redoIsPressed(_ sender: Any) {
    }
    
    @IBAction func plusIsPressed(_ sender: Any) {
        operationType = .plus
        enableSecondOperandTextFieldAndResetText(isEnabled: true)
    }
    
    @IBAction func minusIsPressed(_ sender: Any) {
        operationType = .minus
        enableSecondOperandTextFieldAndResetText(isEnabled: true)
    }
    
    @IBAction func DividIsPressed(_ sender: Any) {
        operationType = .divid
        enableSecondOperandTextFieldAndResetText(isEnabled: true)
    }
    
    @IBAction func multiplyIsPressed(_ sender: Any) {
        operationType = .multiply
        enableSecondOperandTextFieldAndResetText(isEnabled: true)
    }
    
    @IBAction func equalIsPressed(_ sender: Any) {
        if secondOperandTextField.text != nil && operationType != nil {
            secondOperand = Double(secondOperandTextField.text ?? "0")
            presenter?.executeOperation(operation: Operation(firstOperand: result, secondOperand: secondOperand!, operationSign: operationType!))
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
        enableSecondOperandTextFieldAndResetText(isEnabled: false)
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
}

extension CalculatorViewController: CalculatorViewProtocol, UITextFieldDelegate  {
    func operationExecuted(operation: Operation) {
        calculatedOperations.append(operation)
        result = operation.firstOperand
        resultLabel.text = "Result = \(operation.firstOperand)"
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

