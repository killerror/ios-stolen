//
//  TableViewController.swift
//  myProject
//
//  Created by Максим Бобков on 11.01.2024.
//

import UIKit

final class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.4459383488, green: 0.9433882236, blue: 0.7126674056, alpha: 1)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        CustomTableNewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Section 1"
        } else if section == 1 {
            return "Section 2"
        } else {
            return "Section 3"
        }
    }
}


#Preview {
    TableViewController()
}
