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

class SharedGoalTableViewController: UITableViewController {
    
    var goalData: [GoalData]?
    var userData: FBUserData?
    var activityView: UIActivityIndicatorView?
    
    var emptyLabel: UITextView = {
        var textView = UITextView()
        let subtitleText = NSAttributedString(string: "No goals shared with you so far", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.gray])
        let mutableAttributedString = NSMutableAttributedString(attributedString: subtitleText)
        textView.attributedText = mutableAttributedString
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emptyLabel)
        emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showActivityIndicator()
        self.goalData = fetchSharedGoals()
        if self.goalData?.count != 0 {
            emptyLabel.isHidden = true
            tableView.register(GoalInfoCell.self, forCellReuseIdentifier: "goalInfoCell")
            tableView.reloadData()
        } else {
            emptyLabel.isHidden = false
        }
        self.tabBarController?.tabBar.isHidden = false
        addNavBarButtons()
        
        DispatchQueue.main.async {
            self.hideActivityIndicator()
        }
    }
    
    @objc override func logOutButtonPressed() {
        self.userData = nil
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc override func addButtonPressed() {
        let addGoalController = AddGoalController()
        addGoalController.userData = self.userData
        self.tabBarController?.tabBar.isHidden = true
        let navController = UINavigationController(rootViewController: addGoalController)
        present(navController, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .gray)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
    
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
            
        } catch let fetchError {
            print("Unable to fetch goals: \(fetchError)")
        }
        return []
    }
}

extension SharedGoalTableViewController {
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
        cell.creatorTextView.text = "Created by: \(goalData![indexPath.row].goalCreatedUserName)"
        cell.creatorTextView.text.append(goalData![indexPath.row].goalCreatedUserEmail.caseInsensitiveCompare(userData!.emailId) == ComparisonResult.orderedSame ? " (You) " : " (Your Friend)")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
