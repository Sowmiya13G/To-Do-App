//
//  ViewController.swift
//  To Do App
//
//  Created by DB-MM-002 on 04/08/23.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Variable Declaration
    var items = [String]()
    // MARK: - IBOutlet and Actions
    @IBOutlet weak var lblForTitle: UILabel!
    @IBOutlet weak var tblViewforList: UITableView!
    @IBAction func btnToAdd(_ sender: Any) {
        didTapped()
    }
    // MARK: - ViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    // MARK: - UI Functions
    func setUI(){
//        view.addSubview(tblViewforList)
        self.tblViewforList.dataSource = self
        self.tblViewforList.delegate = self
//        tblViewforList.register(UITableViewCell.self, forCellReuseIdentifier: "ItemTableViewCell")
        let textFieldCell = UINib(nibName: "ListTableViewCell",
                                  bundle: nil)
        self.tblViewforList.register(textFieldCell , forCellReuseIdentifier: "ListTableViewCell")
    }
    private func saveItems() {
        UserDefaults.standard.set(items, forKey: "SavedItems")
    }

    private func loadItems() {
        if let savedItems = UserDefaults.standard.stringArray(forKey: "SavedItems") {
            items = savedItems
            tblViewforList.reloadData()
        }
    }
    
    @objc private func didTapped(){
        let alert = UIAlertController(title: "New Item", message: "Enter new to-do Item", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Enter item..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak self] (_) in
            if let field = alert.textFields?.first, let text = field.text, !text.isEmpty {
                self?.items.append(text)
                self?.tblViewforList.reloadData()
                self?.saveItems()
            }
        }))
        present(alert, animated: true)
    }
    private func editTask(at index: Int) {
        let alert = UIAlertController(title: "Edit Item", message: "Edit to-do Item", preferredStyle: .alert)
        alert.addTextField { field in
            field.text = self.items[index] // Set the current text in the text field
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] (_) in
            if let field = alert.textFields?.first, let newText = field.text, !newText.isEmpty {
                self?.items[index] = newText // Update the item in the array
                self?.tblViewforList.reloadData()
                self?.saveItems() // Save the updated items array
            }
        }))
        present(alert, animated: true)
    }
}
// MARK: - DataSource & Delegate Methods
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell {
            cell.lblForTask?.text = items[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            self?.items.remove(at: indexPath.row)
            self?.tblViewforList.reloadData()
            self?.saveItems()
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//    let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, completionHandler) in
//        self?.editTask(at: indexPath.row)
//        completionHandler(true)
//    }
//    editAction.backgroundColor = .blue
//    return UISwipeActionsConfiguration(actions: [editAction])
//}
