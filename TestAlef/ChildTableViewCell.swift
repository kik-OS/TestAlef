//
//  ChildTableViewCell.swift
//  TestAlef
//
//  Created by Никита Гвоздиков on 01.06.2021.
//

import UIKit

class ChildTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var nameTextField: UITextField!
    @IBOutlet weak private var ageTextField: UITextField!
    @IBOutlet weak var childNumberLabel: UILabel!
    
    // MARK: - Properties
    
    var delegate: MainTableViewControllerDelegate?
    var child: Child?
    
    // MARK: - IB Actions
    
    @IBAction func nameTF() {
        delegate?.editChild(child: child ?? Child(), name: nameTextField.text, age: nil)
    }
    
    @IBAction func ageTF() {
        delegate?.editChild(child: child ?? Child(), name: nil, age: ageTextField.text)
    }
    
    // MARK: - Actions
    
    @IBAction func closedButtonTaped() {
        guard let child = child else {return}
        delegate?.deleteChild(child: child)
        nameTextField.text = ""
        ageTextField.text = ""
    }
}
