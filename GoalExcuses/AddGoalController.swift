//
//  AddGoalController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/25/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import UIKit

class AddGoalController: UIViewController, UITextViewDelegate
{
    
    var goalNameText: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.text = "Goal Name"
        
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
        textView.text = "\n\n\nGoal Description"
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
        textView.text = "\n\n\nFriends Email Id seperated by Comma"
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
        let text = NSAttributedString(string: "Goal Not shared with users ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
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
        
        
        
        
        addGoalButton.addTarget(self, action: #selector(addAGoal), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelButtonPressed))

        goalDescText.delegate = self
        goalNameText.delegate = self
        goalSharedEmailText.delegate = self
        
        goalNameText.becomeFirstResponder()
        
        errorMessageLabel.isHidden = true
    }
    
    @objc func addAGoal() {
        print("Add a Goal clicked")
    
        guard !goalNameText.text.isEmpty && !(goalNameText.text == "Goal Name" && goalNameText.textColor == UIColor.lightGray)  && goalDescText.text != "\n\n\nGoal Description" && !(goalDescText.text == "\n\n\nGoal Description" && goalNameText.textColor == UIColor.lightGray) && !goalDescText.text.isEmpty else {
            displayErrorMessage(errorTitle: "Missing mandatory values", errorMessage: "Please make sure to enter Goal name, description")
            return
        }
        guard !goalSharedEmailText.text.isEmpty && !(goalSharedEmailText.text == "\n\n\nFriends Email Id seperated by Comma") && !(goalSharedEmailText.textColor == UIColor.lightGray) else {
            displayErrorMessage(errorTitle: "Missing mandatory values", errorMessage: "Please make sure to enter friend email Ids")
            goalSharedEmailText.becomeFirstResponder()
            return
        }
        let emailAddressSplit = goalSharedEmailText.text.split(separator: ",").filter { (inputString) -> Bool in
            return isValidEmail(String(inputString))
        }
        
        let inviteNotSentUsers = goalSharedEmailText.text.split(separator: ",").filter { firstElement in !emailAddressSplit.contains { secondElement in return String(firstElement) == String(secondElement) } }
        
        if !inviteNotSentUsers.isEmpty {
            displayErrorMessage(errorTitle: "Please provide valid Email Ids", errorMessage: "Emails should be in the format of xxx@abc.com")
            errorMessageLabel.text = "Goal Not shared with users \(inviteNotSentUsers)"
            errorMessageLabel.isHidden = false
        }
        
        print(emailAddressSplit)
    }
    
    @objc func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor != UIColor.black {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty && textView == goalDescText {
            textView.text = "\n\n\nGoal Description"
            textView.textColor = UIColor.lightGray
        } else if textView.text.isEmpty && textView == goalNameText {
            textView.text = "Goal Name"
            textView.textColor = UIColor.lightGray
        } else if textView.text.isEmpty && textView == goalSharedEmailText {
            textView.text = "\n\n\nFriends Email Id seperated by Comma"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func isValidEmail(_ inputString: String) -> Bool {
        let regEx = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        return regEx.firstMatch(in: inputString, options: [], range: NSRange(location: 0, length: inputString.count)) != nil
    }
    
}
