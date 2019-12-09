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
        let subtitleText = NSAttributedString(string: "\n\n\nJust login with any of the platforms below and you're on your way to achieve your goal", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.delegate = self
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([loginButton.heightAnchor.constraint(equalToConstant: 60)])
//        NSLayoutConstraint.activate([loginButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 32),
//                                    loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
//                                    loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80)])
        setupUIOnTheScreen()
    }
    
    private func setupUIOnTheScreen() {
        
        var imageView = UIView()
        imageView.addSubview(goalExcuseImage)
        
        var descriptionView = UIView()
        descriptionView.addSubview(goalExcuseTextAndDescription)
        
        
        var stackView = UIStackView(arrangedSubviews: [imageView,descriptionView,loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        var loginButtonsView = UIStackView()
        
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
}
