//
//  MainTableViewController.swift
//  TestAlef
//
//  Created by Никита Гвоздиков on 01.06.2021.
//

import UIKit

// MARK: - Protocols

protocol MainTableViewControllerDelegate {
    func addChild()
    func deleteChild(child: Child)
    func editChild(child: Child, name: String?, age: String?)
    func editParent(fullName: String?, age: String?)
}

class MainTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var parentInfo: Parent?
    private var countOfSections = 1
    private var delegate: ParentTableViewCellDelegate?

    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parentInfo = Parent.getParent()
        configureGestureRecognizer()
        tableView.estimatedRowHeight = 192
    }
    
    // MARK: - IB Actions
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        print("""
            Пользователь: \(parentInfo?.fullName ?? "")
            Возраст: \(parentInfo?.age ?? 0)
            количество детей: \(parentInfo?.children.count ?? 0)
            """)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return countOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return parentInfo?.children.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "parent", for: indexPath) as? ParentTableViewCell
            cell?.delegate = self
            delegate = cell
            return cell ?? UITableViewCell()
        } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "child", for: indexPath) as? ChildTableViewCell
        cell?.delegate = self
        cell?.child = parentInfo?.children[indexPath.row]
        cell?.childNumberLabel.text = "👶🏻  Ребенок \(indexPath.row + 1)"
        return cell ?? UITableViewCell()
        }
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
    
    func addChild() {
        parentInfo?.children.append(Child(name: nil, age: nil))
        delegate?.updateButtonState(countOfCell: parentInfo?.children.count ?? 0)
        if countOfSections == 1 {
            countOfSections += 1
            let indexSet = IndexSet(integer: countOfSections - 1)
            tableView.insertSections(indexSet, with: .left)
        } else {
            tableView.insertRows(at: [IndexPath(row: (parentInfo?.children.count ?? 1) - 1 , section: 1)], with: .left)
        }
    }
    
    func deleteChild(child: Child) {
        guard let index = parentInfo?.children.firstIndex(where: {$0.id == child.id}) else {return}
        parentInfo?.children.remove(at: index)
        delegate?.updateButtonState(countOfCell: parentInfo?.children.count ?? 0)
        tableView.deleteRows(at: [IndexPath(row: index, section: 1)], with: .left)
        if parentInfo?.children.count == 0 {
            countOfSections = 1
            tableView.deleteSections([1], with: .none)
        }
    }
    
    func editChild(child: Child, name: String?, age: String?) {
        guard let index = parentInfo?.children.firstIndex(where: {$0.id == child.id}) else {return}
        if name != nil && name != "" {
            parentInfo?.children[index].name = name
        }
        
        guard let noNilAge = age else {return}
        if let ageInt = Int(noNilAge) {
            parentInfo?.children[index].age = ageInt
        }
    }
    
    func editParent(fullName: String?, age: String?) {
        if fullName != nil && fullName != "" {
            parentInfo?.fullName = fullName
        }
        
        guard let noNilAge = age else {return}
        if let ageInt = Int(noNilAge) {
            parentInfo?.age = ageInt
        }
    }
}



