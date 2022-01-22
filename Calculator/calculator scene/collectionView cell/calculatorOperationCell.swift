//
//  calculatorOperationCell.swift
//  Calculator
//
//  Created by azah on 1/22/22.
//

import UIKit

class calculatorOperationCell: UICollectionViewCell {
    @IBOutlet weak var opertionLabel: UILabel!
    @IBOutlet weak var secondOperandLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(operation: Operation) {
        opertionLabel.text = operation.operationSign.rawValue
        secondOperandLabel.text = "\(operation.secondOperand)"
    }

}
