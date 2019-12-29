//
//  SharedGoalTableViewController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/15/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import UIKit

class SharedGoalTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarButtons()
    }
    
    @objc override func logOutButtonPressed() {
        print("Logout Button Pressed from shared goal")
    }
    
    @objc override func addButtonPressed() {
        print("Add Button Pressed from shared goal")
    }
    
}
