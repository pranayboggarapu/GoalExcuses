//
//  CustomGoalController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/31/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import UIKit

class CustomGoalController: UITableViewController {
    
    //MARK:- Elements declaration
    var userData: FBUserData?
    var activityView: UIActivityIndicatorView?
    var goalData: [GoalData]?
   
    //MARK:- UI Elements
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
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(emptyLabel)
        emptyLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
    }
    
    func preViewAppear() {
        showActivityIndicator()
        self.tableView.register(GoalInfoCell.self, forCellReuseIdentifier: "goalInfoCell")
        
        tableDisplayOrLabelDisplay()
        self.tabBarController?.tabBar.isHidden = false
        self.addNavBarButtons()
    }
    
    func showActivityIndicator() {
        //show activity indicator
        activityView = UIActivityIndicatorView(style: .gray)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        //hide activity indicator
        if (activityView != nil){
            DispatchQueue.main.async {
                self.activityView?.stopAnimating()
            }
        }
    }
    
    func tableDisplayOrLabelDisplay() {
        //if goal count is 0
        if self.goalData?.count != 0 {
            emptyLabel.isHidden = true
        } else {
            emptyLabel.isHidden = false
        }
    }

    
    //MARK:- button press functionality
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
}
