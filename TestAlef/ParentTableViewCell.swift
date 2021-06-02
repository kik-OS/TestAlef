//
//  ParentTableViewCell.swift
//  TestAlef
//
//  Created by Никита Гвоздиков on 01.06.2021.
//

import UIKit

// MARK: - Protocols
protocol ParentTableViewCellDelegate {
    func updateButtonState(countOfCell: Int)
}

class ParentTableViewCell: UITableViewCell, ParentTableViewCellDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var addNewChildButton: UIButton!
    
    // MARK: - Properties
    
    var delegate: MainTableViewControllerDelegate?
    
    // MARK: - IB Actions
    
    @IBAction func fullNameTF(_ sender: UITextField) {
        delegate?.editParent(fullName: sender.text, age: nil)
    }
    
    @IBAction func ageTF(_ sender: UITextField) {
        delegate?.editParent(fullName: nil, age: sender.text)
    }
    
    @IBAction func addNewChildButtonPressed() {
        delegate?.addChild()
    }
    
    // MARK: - Methods
    
    func updateButtonState(countOfCell: Int) {
        addNewChildButton.isEnabled = countOfCell < 5
    }
    
}
