//
//  YourGoalTableViewController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/15/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class YourGoalTableViewController: UITableViewController {
    
    var goalData: [GoalData]?
    var userData: FBUserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.goalData = fetchGoals()
        self.tabBarController?.tabBar.isHidden = false
        addNavBarButtons()
        tableView.register(GoalInfoCell.self, forCellReuseIdentifier: "goalInfoCell")
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    @objc override func logOutButtonPressed() {
        print("Logout Button Pressed from your goal")
    }
    
    @objc override func addButtonPressed() {
        let addGoalController = AddGoalController()
        addGoalController.userData = self.userData
        self.tabBarController?.tabBar.isHidden = true
        let navController = UINavigationController(rootViewController: addGoalController)
        present(navController, animated: true, completion: nil)
    }
    
    private func fetchGoals() -> [GoalData] {
        //Fetching the Goal Data
        let context = CoreDataManagerSingleton.shared.persistentContainer.viewContext
        self.goalData?.removeAll()
        var goalsList: [GoalData] = []
        let fetchRequest = NSFetchRequest<CoreData_Goal>(entityName: "CoreData_Goal")
        do {
            let goals = try context.fetch(fetchRequest)
            goals.forEach { (specificGoal) in
                let currentGoal = GoalData(goalName: specificGoal.goalName!, goalDesc: specificGoal.goalDesc!, goalCreatedDate: specificGoal.goalCreatedDate!, goalSharedUsers: (specificGoal.goalSharedUsers!), goalCreatedUserEmail: specificGoal.goalCreatedUserEmail!, goalCreatedUserName: specificGoal.goalCreatedUserName!)
                goalsList.append(currentGoal)
            }
            return goalsList
            
        } catch let fetchError {
            print("Unable to fetch goals: \(fetchError)")
        }
        return []
    }
}

extension YourGoalTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (goalData!.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalInfoCell", for: indexPath) as! GoalInfoCell
        cell.goalCreatedDate.text = goalData![indexPath.row].goalCreatedDate
        cell.goalName.text = goalData![indexPath.row].goalName
        cell.goalDescription.text = goalData![indexPath.row].goalDesc
        let headerText = NSAttributedString(string: "Shared With: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        let subtitleText = NSAttributedString(string: "\(goalData![indexPath.row].goalSharedUsers.joined(separator: " , "))", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 12)])
        let mutableAttributedString = NSMutableAttributedString(attributedString: headerText)
        mutableAttributedString.append(subtitleText)
        cell.sharedWithTextView.attributedText = mutableAttributedString
        cell.creatorTextView.text = "Created by: \(goalData![indexPath.row].goalCreatedUserName) (You)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
