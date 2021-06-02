//
//  MainTableViewController.swift
//  TestAlef
//
//  Created by Никита Гвоздиков on 01.06.2021.
//

import UIKit

// MARK: - Protocols

protocol MainTableViewControllerDelegate {
    func addNewChild()
    func deleteChild(indexPath: IndexPath)
}

class MainTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var data: Parent?
    private var countOfSections = 1
    private var delegate: ParentTableViewCellDelegate?
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = Parent.getParent()
        configureGestureRecognizer()
        tableView.estimatedRowHeight = 192
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return countOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return data?.children.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "parent", for: indexPath) as? ParentTableViewCell
            cell?.delegate = self
            delegate = cell
            return cell ?? UITableViewCell()
            
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "child", for: indexPath) as? ChildTableViewCell
        cell?.delegate = self
        cell?.indexPath = indexPath
        cell?.childNumberLabel.text = "👶🏻  Ребенок \(indexPath.row + 1)"
        return cell ?? UITableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Информация о себе"
        } else {
            return "Информация о детях"
        }
    }
    
    // MARK: - Private methods
    
    private func configureGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(oneTouchOnScrollView))
        tableView.addGestureRecognizer(recognizer)
    }
    
    @objc private func oneTouchOnScrollView() {
        view.endEditing(true)
    }
}

// MARK: - Extension

extension MainTableViewController: MainTableViewControllerDelegate {
    func addNewChild() {
        data?.children.append(Child(name: nil, age: nil))
        delegate?.updateButtonState(countOfCell: data?.children.count ?? 0)
        if countOfSections == 1 {
            countOfSections += 1
            let indexSet = IndexSet(integer: countOfSections - 1)
            tableView.insertSections(indexSet, with: .left)
        } else {
            tableView.insertRows(at: [IndexPath(row: (data?.children.count ?? 1) - 1 , section: 1)], with: .left)
        }
        
    }
    
    func deleteChild(indexPath: IndexPath) {
        data?.children.remove(at: indexPath.row)
        delegate?.updateButtonState(countOfCell: data?.children.count ?? 0)
        tableView.deleteRows(at: [indexPath], with: .left)
        
        if data?.children.count == 0 {
            countOfSections = 1
            tableView.deleteSections([1], with: .none)
        }
        tableView.reloadData()
    }
    
    
}



