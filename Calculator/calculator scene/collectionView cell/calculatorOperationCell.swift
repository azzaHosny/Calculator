//
//  calculatorOperationCell.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import UIKit

class calculatorOperationCell: UICollectionViewCell {
    @IBOutlet weak var secondOperandLabel: UILabel!
    @IBOutlet weak var outerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outerView.layer.borderWidth = 2
        outerView.layer.borderColor = UIColor.white.cgColor
    }
    
    func configure(operation: Operation) {
        secondOperandLabel.text = operation.concatentedOpertionAndSecondOperand
    }

}
