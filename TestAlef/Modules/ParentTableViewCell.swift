//
//  ParentTableViewCell.swift
//  TestAlef
//
//  Created by Никита Гвоздиков on 01.06.2021.
//

import UIKit

// MARK: - Protocols

protocol ParentTableViewCellDelegate: AnyObject {
    func editParent(fullName: String?, age: String?)
    func addChild()
}

final class ParentTableViewCell: UITableViewCell, MainTableViewControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet private var addNewChildButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: ParentTableViewCellDelegate?
    
    // MARK: - IB Actions
    
    @IBAction private func fullNameTF(_ sender: UITextField) {
        delegate?.editParent(fullName: sender.text, age: nil)
    }
    
    @IBAction private func ageTF(_ sender: UITextField) {
        delegate?.editParent(fullName: nil, age: sender.text)
    }
    
    @IBAction private func addNewChildButtonPressed() {
        delegate?.addChild()
    }
    
    // MARK: - Methods
    
    func updateButtonState(countOfCell: Int) {
        addNewChildButton.isEnabled = countOfCell < 5
    }
    
}
