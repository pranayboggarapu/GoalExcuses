//
//  AddGoalController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/25/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddGoalController: UIViewController, UITextViewDelegate
{
    var goalData: GoalData?
    var goalsList: [CoreData_Goal]?
    var isGoalGettingEdited: Bool = false
    var indexGoalEdited: Int = 0
    
    enum Constants {
        static var goalNameLabel = "Goal Name"
        static var goalDescriptionLabel = "\n\n\nGoal Description"
        static var goalSharedEmailTextLabel = "\n\n\nFriends Email Id seperated by Comma"
        static var goalNotSharedErrorLabel = "Goal Not shared with users "
    }
    
    var userData: FBUserData?
    var activityView: UIActivityIndicatorView?
    
    var goalNameText: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.text = Constants.goalNameLabel
        
        textView.textColor = UIColor.black
        textView.layer.cornerRadius = 8.0
        textView.layer.masksToBounds = true
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2.0
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainer.maximumNumberOfLines = 1
        return textView
    }()
    
    var goalDescText: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.text = Constants.goalDescriptionLabel
        textView.textColor = UIColor.black
        textView.layer.cornerRadius = 8.0
        textView.layer.masksToBounds = true
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2.0
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    var goalSharedEmailText: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.text = Constants.goalSharedEmailTextLabel
        textView.textColor = UIColor.black
        textView.layer.cornerRadius = 8.0
        textView.layer.masksToBounds = true
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2.0
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    var addGoalButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 64/255, green: 128/255, blue: 255/255, alpha: 1.0)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Add a Goal", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var errorMessageLabel: UITextView = {
        var textView = UITextView()
        let text = NSAttributedString(string: Constants.goalNotSharedErrorLabel, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
        let mutableAttributedString = NSMutableAttributedString(attributedString: text)
        textView.attributedText = mutableAttributedString
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupButtonsAndTargets()
        
        goalDescText.delegate = self
        goalNameText.delegate = self
        goalSharedEmailText.delegate = self
        goalNameText.becomeFirstResponder()
        
        if let goalData = goalData {
            goalNameText.text = goalData.goalName
            goalNameText.textColor = UIColor.black
            goalDescText.text = goalData.goalDesc
            goalDescText.textColor = UIColor.black
            goalSharedEmailText.text = goalData.goalSharedUsers.joined(separator: ",")
            goalSharedEmailText.textColor = UIColor.black
            addGoalButton.setTitle("Update the Goal", for: .normal)
            isGoalGettingEdited = true
        }
    }
    
    private func setupButtonsAndTargets() {
        addGoalButton.addTarget(self, action: #selector(addAGoal), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonPressed))
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        self.title = "Add a Goal"
        view.addSubview(goalNameText)
        goalNameText.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        goalNameText.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -25).isActive = true
        goalNameText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75).isActive = true
        goalNameText.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        view.addSubview(goalDescText)
        goalDescText.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        goalDescText.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -25).isActive = true
        goalDescText.topAnchor.constraint(equalTo: goalNameText.bottomAnchor, constant: 50).isActive = true
        goalDescText.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        view.addSubview(goalSharedEmailText)
        goalSharedEmailText.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        goalSharedEmailText.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -25).isActive = true
        goalSharedEmailText.topAnchor.constraint(equalTo: goalDescText.bottomAnchor, constant: 50).isActive = true
        goalSharedEmailText.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        view.addSubview(errorMessageLabel)
        
        errorMessageLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 25).isActive = true
        errorMessageLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -25).isActive = true
        errorMessageLabel.topAnchor.constraint(equalTo: goalSharedEmailText.bottomAnchor, constant: 50).isActive = true
        
        view.addSubview(addGoalButton)
        addGoalButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        addGoalButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -25).isActive = true
        addGoalButton.topAnchor.constraint(equalTo: errorMessageLabel.bottomAnchor, constant: 50).isActive = true
        addGoalButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        errorMessageLabel.isHidden = true
    }
    
    @objc func addAGoal() {
        showActivityIndicator()
        isGoalGettingEdited ? validateUserDetailsAndInsertTheData(updateDataInLocalDB(_:)) : validateUserDetailsAndInsertTheData(addDataToLocalDB(_:))
        hideActivityIndicator()
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
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
}

extension AddGoalController {
    func addDataToLocalDB(_ goalData: GoalData) {
        let context = CoreDataManagerSingleton.shared.persistentContainer.viewContext
        let goal = NSEntityDescription.insertNewObject(forEntityName: "CoreData_Goal", into: context)
        
        goal.setValue(goalData.goalName, forKey: "goalName")
        goal.setValue(goalData.goalDesc, forKey: "goalDesc")
        goal.setValue(goalData.goalCreatedDate, forKey: "goalCreatedDate")
        goal.setValue(goalData.goalSharedUsers, forKey: "goalSharedUsers")
        goal.setValue(goalData.goalCreatedUserEmail, forKey: "goalCreatedUserEmail")
        goal.setValue(goalData.goalCreatedUserName, forKey: "goalCreatedUserName")
        
        //perform the save
        do {
            try context.save()
        } catch _ {
            displayErrorMessage(errorTitle: "Error!!", errorMessage: "An unforeseen error occurred during saving the goal")
        }
        DispatchQueue.main.async {
            self.activityView?.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func updateDataInLocalDB(_ goalData: GoalData) {
        let context = CoreDataManagerSingleton.shared.persistentContainer.viewContext
        do {
            context.delete(goalsList![indexGoalEdited])
            let goal = NSEntityDescription.insertNewObject(forEntityName: "CoreData_Goal", into: context)
            
            goal.setValue(goalData.goalName, forKey: "goalName")
            goal.setValue(goalData.goalDesc, forKey: "goalDesc")
            goal.setValue(goalData.goalCreatedDate, forKey: "goalCreatedDate")
            goal.setValue(goalData.goalSharedUsers, forKey: "goalSharedUsers")
            goal.setValue(goalData.goalCreatedUserEmail, forKey: "goalCreatedUserEmail")
            goal.setValue(goalData.goalCreatedUserName, forKey: "goalCreatedUserName")
            try context.save()
            
        } catch _ {
            displayErrorMessage(errorTitle: "Error!!", errorMessage: "An unforeseen error occurred during updating the details")
        }
        DispatchQueue.main.async {
            self.activityView?.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func validateUserDetailsAndInsertTheData(_ completionHandler: @escaping (GoalData) -> Void) {
        
        let goalNameTextValue = goalNameText.text.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "")
        let goalDescTextValue = goalDescText.text.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\t", with: "")
        let goalSharedEmailTextValue = goalSharedEmailText.text.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "\n", with: "")
        
        if goalNameTextValue.isEmpty || (goalNameTextValue == Constants.goalNameLabel && goalNameText.textColor == UIColor.lightGray) || (goalDescTextValue == Constants.goalDescriptionLabel && goalDescText.textColor == UIColor.lightGray) || goalDescTextValue.isEmpty {
            displayErrorMessage(errorTitle: "Missing mandatory values", errorMessage: "Please make sure to enter Goal name, description")
            return
        }
        guard !goalSharedEmailTextValue.isEmpty && !(goalSharedEmailTextValue == Constants.goalSharedEmailTextLabel) && !(goalSharedEmailText.textColor == UIColor.lightGray) else {
            displayErrorMessage(errorTitle: "Missing mandatory values", errorMessage: "Please make sure to enter friend email Ids")
            goalSharedEmailText.becomeFirstResponder()
            return
        }
        let emailAddressSplit = goalSharedEmailTextValue.split(separator: ",").filter { (inputString) -> Bool in
            return isValidEmail(String(inputString))
        }
        
        let inviteNotSentUsers = goalSharedEmailTextValue.split(separator: ",").filter { firstElement in !emailAddressSplit.contains { secondElement in return String(firstElement) == String(secondElement) } }
        
        if !inviteNotSentUsers.isEmpty {
            displayErrorMessage(errorTitle: "Please provide valid Email Ids", errorMessage: "Emails should be in the format of xxx@abc.com")
            errorMessageLabel.text = "Goal Not shared with users \(inviteNotSentUsers)"
            errorMessageLabel.isHidden = false
            return
        }
        
        var toBeSavedStrings: [String] = []
        for subseq in emailAddressSplit {
            toBeSavedStrings.append(String(subseq).trimmingCharacters(in: .whitespacesAndNewlines))
        }
        
        let goalToBeInserted = GoalData(goalName: goalNameTextValue, goalDesc: goalDescTextValue, goalCreatedDate: returnFormattedDate(), goalSharedUsers: toBeSavedStrings, goalCreatedUserEmail: userData!.emailId, goalCreatedUserName: userData!.name)
        
        completionHandler(goalToBeInserted)
    }
    
    func returnFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        let createdDate = dateFormatter.string(from: Date())
        return createdDate
    }
    
    func isValidEmail(_ inputString: String) -> Bool {
        let regEx = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regEx.firstMatch(in: inputString, options: [], range: NSRange(location: 0, length: inputString.count)) != nil
    }
}

extension AddGoalController {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor != UIColor.black {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty && textView == goalDescText {
            textView.text = Constants.goalDescriptionLabel
            textView.textColor = UIColor.lightGray
        } else if textView.text.isEmpty && textView == goalNameText {
            textView.text = Constants.goalNameLabel
            textView.textColor = UIColor.lightGray
        } else if textView.text.isEmpty && textView == goalSharedEmailText {
            textView.text = Constants.goalSharedEmailTextLabel
            textView.textColor = UIColor.lightGray
        }
    }
}
