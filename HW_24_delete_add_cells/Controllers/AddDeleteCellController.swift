//
//  AddDeleteCellController.swift
//  HW_24_delete_add_cells
//
//  Created by Nataliia Storozheva on 27.05.2020.
//  Copyright © 2020 Nataliia Storozheva. All rights reserved.
//

import UIKit

class AddDeleteCellController: TableViewController {
    
    private let initDataSourceForFirstSection = [Int.random(in: 0...100),
    Int.random(in: 0...100),
    Int.random(in: 0...100)]
    
    private let initDataSourceForSecondSection = [Int.random(in: 0...100),
       Int.random(in: 0...100),
       Int.random(in: 0...100),
       Int.random(in: 0...100)]
    
    let indexPathSection = IndexPath()
    
    override func setup() {
        super.setup()
        title = "HW_24 Add end Delete cell"
    }

    override func viewDidLoad() {
            super.viewDidLoad()
       
        
        dataSource.append(contentsOf: initDataSourceForFirstSection)
//
//            dataSource.append(contentsOf: initDataSourceForSecondSection)
       
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
            
            let refreshControll = UIRefreshControl()
            refreshControll.addTarget(self, action: #selector(renewData), for: UIControl.Event.valueChanged)
            tableView?.refreshControl = refreshControll
            
        }

        //MARK: - Refresh Data
        @objc private func renewData() {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.dataSource.removeAll()
                
//                       if self.indexPathSection.section == 0 {
//                         self.dataSource.append(contentsOf: self.initDataSourceForFirstSection)
//               } else {
//             self.dataSource.append(contentsOf: self.initDataSourceForSecondSection)
//                }
                self.tableView?.reloadData()
                self.tableView?.refreshControl?.endRefreshing()
  
            }
        }
        
        //MARK: - Actions
        @objc private func addButtonClicked() {
   
           
            let index = 0
            let insertIndex = index <= dataSource.count ? index : dataSource.count
            
            dataSource.insert(Int.random(in: 0...100), at: insertIndex)
            
            let indexPath = IndexPath(row: insertIndex, section: 0)
            tableView?.insertRows(at: [indexPath], with: .automatic)
            
        }
   
        //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 2

     }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 0
        
        switch section {
        case 0:
            result = dataSource.count
      
       
        default:
            result = dataSource.count
            
        }
        
        return result
    }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            var cellIdentifier = ""
                   switch indexPath.section {
                   case 1:
                       cellIdentifier = "cell_id_1"
                   default:
                       cellIdentifier = "cell_id"
                   }
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    
            
            if indexPath.section == 0 {
               
                if let number = dataSource[indexPath.row] as? Int {
                                     cell.textLabel?.text = String(number)
                            }
            } else {
               
                if let number = dataSource[indexPath.row] as? Int {
                                                   cell.textLabel?.text = String(number)
            }
            }
         
            return cell
        }
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                dataSource.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var result: String?
        result = "секция No  \(section + 1)"
        return result
    }
 
   }

