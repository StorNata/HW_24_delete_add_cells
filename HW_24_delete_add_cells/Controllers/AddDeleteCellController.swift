//
//  AddDeleteCellController.swift
//  HW_24_delete_add_cells
//
//  Created by Nataliia Storozheva on 27.05.2020.
//  Copyright © 2020 Nataliia Storozheva. All rights reserved.
//

import UIKit

class AddDeleteCellController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView?
    private var items: [(name: String, source: [Int])] = []
    
    let dataSourceForFirstSection = [Int.random(in: 0...100),
                                     Int.random(in: 0...100),
                                     Int.random(in: 0...100)]
    
    let dataSourceForSecondSection = [Int.random(in: 0...100),
                                      Int.random(in: 0...100),
                                      Int.random(in: 0...100),
                                      Int.random(in: 0...100)]
    
    override func setup() {
        super.setup()
        title = "HW_24 Add end Delete cell"
        setupItems()
    }
    
    private func setupItems() {
        items.removeAll()
        items.append((name: "Section 1", source: dataSourceForFirstSection))
        items.append((name: "Section 2", source: dataSourceForSecondSection))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        let refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(renewData), for: UIControl.Event.valueChanged)
        tableView?.refreshControl = refreshControll
    }
    
    //MARK: - Refresh Data
    @objc private func renewData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            self?.setupItems()
            self?.tableView?.reloadData()
            self?.tableView?.refreshControl?.endRefreshing()
        }
    }
    
    //MARK: - Actions add
    @objc private func addButtonClicked() {
        
        let row = 0
        let section = 0
        
        items[section].source.insert(Int.random(in: 0...100), at: row)
        items[section].source.insert(Int.random(in: 0...100), at: row + 1)
        
        let indexPath1 = IndexPath(row: row, section: section)
        let indexPath2 = IndexPath(row: row + 1, section: section)
        tableView?.insertRows(at: [indexPath1, indexPath2], with: .automatic)
    }
    //MARK: - Actions delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let row = 0
        let section = 1
        
        if editingStyle == .delete && indexPath.section == section {
            
            items[section].source.remove(at: row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return items[section].source.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = ""
        switch indexPath.section {
        case 1:
            cellIdentifier = "cell_id_1"
        default:
            cellIdentifier = "cell_id"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = String(items[indexPath.section].source[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].name
    }
}

