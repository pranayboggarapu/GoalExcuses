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
    var goalsFromLocalDB: [CoreData_Goal]?
    var userData: FBUserData?
    var activityView: UIActivityIndicatorView?
    var emptyLabel: UITextView = {
        var textView = UITextView()
        let subtitleText = NSAttributedString(string: "No goals created by you so far", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.gray])
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
        self.viewDidLoad()
        showActivityIndicator()
        self.goalData = fetchGoals()
        tableDisplayOrLabelDisplay()
        
        self.tabBarController?.tabBar.isHidden = false
        self.addNavBarButtons()
        
        DispatchQueue.main.async {
            self.hideActivityIndicator()
        }
    }
    
    func tableDisplayOrLabelDisplay() {
        if self.goalData?.count != 0 {
            self.tableView.register(GoalInfoCell.self, forCellReuseIdentifier: "goalInfoCell")
            self.tableView.reloadData()
            emptyLabel.isHidden = true
        } else {
            emptyLabel.isHidden = false
        }
    }
    
    @objc override func logOutButtonPressed() {
        showActivityIndicator()
        self.userData = nil
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
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
    
    private func fetchGoals() -> [GoalData] {
        //Fetching the Goal Data
        let context = CoreDataManagerSingleton.shared.persistentContainer.viewContext
        self.goalData?.removeAll()
        var goalsList: [GoalData] = []
        let condition: NSPredicate = NSPredicate(format: "goalCreatedUserEmail == %@", userData!.emailId)
        let fetchRequest = NSFetchRequest<CoreData_Goal>(entityName: "CoreData_Goal")
        fetchRequest.predicate = condition
        do {
            goalsFromLocalDB = try context.fetch(fetchRequest)
            goalsFromLocalDB!.forEach { (specificGoal) in
                let currentGoal = GoalData(goalName: specificGoal.goalName!, goalDesc: specificGoal.goalDesc!, goalCreatedDate: specificGoal.goalCreatedDate!, goalSharedUsers: (specificGoal.goalSharedUsers!), goalCreatedUserEmail: specificGoal.goalCreatedUserEmail!, goalCreatedUserName: specificGoal.goalCreatedUserName!)
                goalsList.append(currentGoal)
            }
            return goalsList
            
        } catch _ {
            displayErrorMessage(errorTitle: "Error!!", errorMessage: "An unforeseen error occurred during fetching the details")
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        showActivityIndicator()
        if editingStyle == .delete {
            let context = CoreDataManagerSingleton.shared.persistentContainer.viewContext
            do {
                context.delete(goalsFromLocalDB![indexPath.row])
                try context.save()
            } catch _ {
                displayErrorMessage(errorTitle: "Error!!", errorMessage: "An unforeseen error occurred during deleting the details")
            }
            self.goalData?.remove(at: indexPath.row)
            self.goalsFromLocalDB?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableDisplayOrLabelDisplay()
        }
        DispatchQueue.main.async {
            self.hideActivityIndicator()
        }
    }
}
