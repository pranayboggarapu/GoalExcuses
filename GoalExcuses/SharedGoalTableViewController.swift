//
//  SharedGoalTableViewController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/15/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SharedGoalTableViewController: CustomGoalController {
    
    //MARK:- View load and appear functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.goalData = fetchSharedGoals()
        tableView.reloadData()
        preViewAppear()
        hideActivityIndicator()
        emptyLabel.text = "No goals shared with you so far"
    }
    
    //MARK:- Fetch goals from DB
    private func fetchSharedGoals() -> [GoalData] {
        //Fetching the Goal Data
        let context = CoreDataManagerSingleton.shared.persistentContainer.viewContext
        self.goalData?.removeAll()
        var goalsList: [GoalData] = []
        //TODO: Was not able to get predicate working
        //let condition: NSPredicate = NSPredicate(format: "goalSharedUsers in %@", userData!.emailId)
//        fetchRequest.predicate = condition
       
        let fetchRequest = NSFetchRequest<CoreData_Goal>(entityName: "CoreData_Goal")
        do {
            let goals = try context.fetch(fetchRequest)
            goals.forEach { (specificGoal) in
                let filteredUsers = specificGoal.goalSharedUsers?.filter({ (oneString) -> Bool in
                    return oneString.caseInsensitiveCompare(userData!.emailId) == ComparisonResult.orderedSame
                })
                if filteredUsers!.count != 0 {
                    let currentGoal = GoalData(goalName: specificGoal.goalName!, goalDesc: specificGoal.goalDesc!, goalCreatedDate: specificGoal.goalCreatedDate!, goalSharedUsers: (specificGoal.goalSharedUsers!), goalCreatedUserEmail: specificGoal.goalCreatedUserEmail!, goalCreatedUserName: specificGoal.goalCreatedUserName!)
                    goalsList.append(currentGoal)
                }
            }
            return goalsList
            
        } catch _ {
            displayErrorMessage(errorTitle: "Error!!", errorMessage: "An unforeseen error occurred during fetching the details")
        }
        return []
    }
}

//MARK:- Table View Delegate functions
extension SharedGoalTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (goalData!.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalInfoCell", for: indexPath) as! GoalInfoCell
        cell.goalCreatedDate.text = goalData![indexPath.row].goalCreatedDate
        cell.goalName.text = goalData![indexPath.row].goalName
        cell.goalDescription.text = goalData![indexPath.row].goalDesc
        //formatting the text display
        let headerText = NSAttributedString(string: "Shared With: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        let subtitleText = NSAttributedString(string: "\(goalData![indexPath.row].goalSharedUsers.joined(separator: " , "))", attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 12)])
        let mutableAttributedString = NSMutableAttributedString(attributedString: headerText)
        mutableAttributedString.append(subtitleText)
        cell.sharedWithTextView.attributedText = mutableAttributedString
        cell.creatorTextView.text = "Created by: \(goalData![indexPath.row].goalCreatedUserName)"
        cell.creatorTextView.text.append(goalData![indexPath.row].goalCreatedUserEmail.caseInsensitiveCompare(userData!.emailId) == ComparisonResult.orderedSame ? " (You) " : " (Your Friend)")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
