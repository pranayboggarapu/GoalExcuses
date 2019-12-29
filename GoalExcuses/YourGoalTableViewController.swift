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
    
    var goalData: [Goal]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        addNavBarButtons()
        tableView.register(GoalInfoCell.self, forCellReuseIdentifier: "goalInfoCell")
        
//        let company = NSEntityDescription.insertNewObject(forEntityName: "Goal", into: context)
//
//        company.setValue("Goal Description \(randomString(length: 4))", forKey: "goalDesc")
//        company.setValue("Goal Name \(randomString(length: 4))", forKey: "goalName")
        
//        //perform the save
//        do {
//            try context.save()
//        } catch let saveErr {
//            print("Failed to save goal \(saveErr)")
//        }
        
        
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (goalData!.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalInfoCell", for: indexPath) as! GoalInfoCell
//        cell.textLabel?.text = goalData![indexPath.row].goalName
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        cell.goalCreatedDate.text = dateFormatter.string(from: Date())
        cell.goalName.text = goalData![indexPath.row].goalName
        cell.goalDescription.text = "Goal Description Goal DescriptionGoal DescriptionGoal DescriptionGoal DescriptionGoal DescriptionGoal Description"
        cell.sharedWithTextView.text = "Shared With: fsadkj@gmail.com, safjd@gmail.com, dsaf@gmail.com,dsaf@gmail.com"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    @objc override func logOutButtonPressed() {
        print("Logout Button Pressed from your goal")
    }
    
    @objc override func addButtonPressed() {
        let addGoalController = AddGoalController()
        self.tabBarController?.tabBar.isHidden = true
        
        let navController = UINavigationController(rootViewController: addGoalController)
        
        present(navController, animated: true, completion: nil)
        
    }
    
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
