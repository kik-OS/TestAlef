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
    var indexPath: IndexPath?
    
    // MARK: - Actions
    
    @IBAction func closedButtonTaped() {
        guard let indexPath = indexPath else {return}
        delegate?.deleteChild(indexPath: indexPath)
        nameTextField.text = ""
        ageTextField.text = ""
    }
}
