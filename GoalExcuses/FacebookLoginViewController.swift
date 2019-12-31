//
//  FacebookLoginViewController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/7/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class FacebookLoginViewController: UIViewController {
    
    //MARK:- UI Elements
    
    let loginButton: UIButton =  {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 64/255, green: 128/255, blue: 255/255, alpha: 1.0)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("My Login", for: .normal)
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
        let subtitleText = NSAttributedString(string: "\n\n\n ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
        let headerText = NSAttributedString(string: "You're almost done, Login via Facebook below!!", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        let mutableAttributedString = NSMutableAttributedString(attributedString: headerText)
        mutableAttributedString.append(subtitleText)
        textView.attributedText = mutableAttributedString
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var activityView: UIActivityIndicatorView?
    
    //MARK:- View Load function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUIOnTheScreen()
        loginButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
    }
    
    //MARK:- UI Setup function
    private func setupUIOnTheScreen() {
        
        let imageView = UIView()
        imageView.addSubview(goalExcuseImage)
        
        let descriptionView = UIView()
        descriptionView.addSubview(goalExcuseTextAndDescription)
        
        
        let loginButtonsView = UIStackView()
        loginButtonsView.addSubview(loginButton)
        NSLayoutConstraint.activate([loginButton.topAnchor.constraint(equalTo: loginButtonsView.topAnchor, constant: 60),
                                     loginButton.heightAnchor.constraint(equalToConstant: 60),
                                     loginButton.leadingAnchor.constraint(equalTo: loginButtonsView.leadingAnchor, constant: 40),
                                     loginButton.trailingAnchor.constraint(equalTo: loginButtonsView.trailingAnchor, constant: -40)])
        
        
        
        
        let stackView = UIStackView(arrangedSubviews: [imageView,descriptionView,loginButtonsView])
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
}
//MARK:- FB Login functionality
extension FacebookLoginViewController {
    @objc func handleCustomFBLogin() {
        showActivityIndicator()
        FacebookClient.loginAndFetchUserDetails(viewController: self, completionHandler: validateFBLoginResponse(isSuccess:actualUserData:error:))
    }
    
    func validateFBLoginResponse(isSuccess: Bool, actualUserData: FBUserData?, error: Error?) {
        if isSuccess {
            DispatchQueue.main.async {
                self.loginSuccessfulGoToNextScreen(actualuserData: actualUserData!)
            }
        } else {
            DispatchQueue.main.async {
                self.displayErrorMessage(errorTitle: "Error", errorMessage: "Some unforeseen error occurred, while logging into Facebook")
            }
        }
        hideActivityIndicator()
    }
    
    func loginSuccessfulGoToNextScreen(actualuserData: FBUserData) {
        let tabController = TabBarController()
        tabController.userData = actualuserData
        tabController.setupTabControllers()
        self.present(tabController, animated: true, completion: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Successfully logged out")
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
