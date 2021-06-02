//
//  ChildTableViewCell.swift
//  TestAlef
//
//  Created by Никита Гвоздиков on 01.06.2021.
//

import UIKit

// MARK: - Protocols

protocol ChildTableViewCellDelegate: AnyObject {
    func addChild()
    func deleteChild(child: Child)
    func editChild(child: Child, name: String?, age: String?)
}

final class ChildTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var ageTextField: UITextField!
    @IBOutlet private var childNumberLabel: UILabel!
    
    // MARK: - Properties
    
    weak var delegate: ChildTableViewCellDelegate?
    private var child: Child?
    
    // MARK: - IB Actions
    
    @IBAction private func nameTF() {
        delegate?.editChild(child: child ?? Child(), name: nameTextField.text, age: nil)
    }
    
    @IBAction private func ageTF() {
        delegate?.editChild(child: child ?? Child(), name: nil, age: ageTextField.text)
    }
    
    @IBAction private func closedButtonTaped() {
        guard let child = child else {return}
        delegate?.deleteChild(child: child)
        nameTextField.text = ""
        ageTextField.text = ""
    }
    
    // MARK: - Public Methods
    
    func configure(child: Child?, numberOfCell: Int) {
        self.child = child
        childNumberLabel.text = "👶🏻  Ребенок \(numberOfCell + 1)"
    }
}
