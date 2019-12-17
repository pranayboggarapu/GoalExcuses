//
//  TabBarController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/15/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    var userData: UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabControllers()
    }
    
    func setupTabControllers() {
        let myGoalController = YourGoalTableViewController(style: .plain)
        myGoalController.title = "My Goals"
        myGoalController.tabBarItem = UITabBarItem(title: "My Goals", image: nil, tag: 0)
        
        let sharedGoalController = SharedGoalTableViewController(style: .plain)
        sharedGoalController.title = "Goals Shared with me"
        sharedGoalController.tabBarItem = UITabBarItem(title: "Shared Goals", image: nil, tag: 1)
        
        let controllers = [myGoalController,sharedGoalController]
                
        self.viewControllers = controllers
        self.viewControllers = controllers.map {UINavigationController(rootViewController: $0)}
    }
    
}
