//
//  TabBarController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/15/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TabBarController: UITabBarController {
    
    var userData: FBUserData?
    
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
        
        myGoalController.goalData = fetchGoals()
        
        let controllers = [myGoalController,sharedGoalController]
                
        self.viewControllers = controllers
        self.viewControllers = controllers.map {UINavigationController(rootViewController: $0)}
    }
    
    
    private func fetchGoals() -> [Goal] {
        
        //Fetching the Goal Data
        let context = CoreDataManagerSingleton.shared.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
            let goals = try context.fetch(fetchRequest)
            goals.forEach { (goal) in
                print(goal.goalDesc ?? "")
                print(goal.goalName ?? "")
            }
            return goals
            
        } catch let fetchError {
            print("Unable to fetch goals: \(fetchError)")
        }
        return []
    }
}
