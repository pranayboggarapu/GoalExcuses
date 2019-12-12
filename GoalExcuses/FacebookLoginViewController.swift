//
//  FacebookLoginViewController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/7/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FacebookLoginViewController: UIViewController, LoginButtonDelegate {
    
    let loginButton: FBLoginButton =  {
        let button = FBLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var goalExcuseImage: UIImageView = {
        var parkingImage = UIImageView()
        parkingImage.image = UIImage(named: "firstGoalExcuseOnboardingImage")
        parkingImage.translatesAutoresizingMaskIntoConstraints = false
        return parkingImage
    }()
    
    var goalExcuseTextAndDescription: UITextView = {
        var textView = UITextView()
        let subtitleText = NSAttributedString(string: "\n\n\nYou're almost there....You're on your way to achieve your goal by cutting down your excuses with the help of friends.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
        let headerText = NSAttributedString(string: "You're almost done!!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        let mutableAttributedString = NSMutableAttributedString(attributedString: headerText)
        mutableAttributedString.append(subtitleText)
        textView.attributedText = mutableAttributedString
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    var labelDescriptionUserName: UITextView = {
        var userNameLabel = UITextView()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.attributedText = NSAttributedString(string: "\n\n\nThis will be your user name going forward.", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.gray])
        userNameLabel.textAlignment = .left
        userNameLabel.isEditable = false
        userNameLabel.isScrollEnabled = false
        return userNameLabel
    }()
    
    var stepsInDetail: UITextView = {
        var textView = UITextView()
        let subtitleText = NSAttributedString(string: "\n\n\n 1. Login in Facebook below.\n\n2. Remember your username.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)])
        textView.attributedText = subtitleText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var randomUserNameText: UITextField = {
        var userName = UITextField()
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.textAlignment = .center
        userName.isUserInteractionEnabled = false
        userName.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 32)])
        return userName
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.delegate = self
        setupUIOnTheScreen()
        randomUserNameText.text = randomString(length: 8)
    }
    
    private func setupUIOnTheScreen() {
        
        var imageView = UIView()
        imageView.addSubview(goalExcuseImage)
        
        var descriptionView = UIView()
        descriptionView.addSubview(goalExcuseTextAndDescription)
        
        var choosingUserName = UIView()
        choosingUserName.addSubview(stepsInDetail)
        
        var loginButtonsView = UIStackView()
        loginButtonsView.addSubview(loginButton)
        NSLayoutConstraint.activate([loginButton.topAnchor.constraint(equalTo: loginButtonsView.topAnchor, constant: 60),
                                     loginButton.heightAnchor.constraint(equalToConstant: 60),
                                     loginButton.leadingAnchor.constraint(equalTo: loginButtonsView.leadingAnchor, constant: 40),
                                     loginButton.trailingAnchor.constraint(equalTo: loginButtonsView.trailingAnchor, constant: -40)])
        
        
        var userNameView = UIStackView(arrangedSubviews: [labelDescriptionUserName, randomUserNameText])
        userNameView.axis = .horizontal
        userNameView.distribution = .fillEqually
        
        var stackView = UIStackView(arrangedSubviews: [imageView,descriptionView,choosingUserName,userNameView,loginButtonsView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.leftAnchor.constraint(equalTo: view.leftAnchor), stackView.rightAnchor.constraint(equalTo: view.rightAnchor), stackView.topAnchor.constraint(equalTo: view.topAnchor), stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        goalExcuseImage.contentMode = .scaleAspectFit
        goalExcuseImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        goalExcuseImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        goalExcuseImage.heightAnchor.constraint(equalTo: descriptionView.heightAnchor).isActive = true
        goalExcuseImage.widthAnchor.constraint(equalTo: descriptionView.widthAnchor).isActive = true
        
        goalExcuseTextAndDescription.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 50).isActive = true
        goalExcuseTextAndDescription.rightAnchor.constraint(equalTo: descriptionView.rightAnchor, constant: -5).isActive = true
        goalExcuseTextAndDescription.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: 5).isActive = true
        goalExcuseTextAndDescription.textAlignment = .center
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Successfully logged out")
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("Error")
        } else {
            print("Success")
            let request = GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
                if err != nil {return}
                print(result)
            }
        }
    }
    
    private func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
