//
//  ViewController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/7/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var goalExcuseImage: UIImageView = {
        var parkingImage = UIImageView(image: UIImage(named: "firstGoalExcuseOnboardingImage"))
        parkingImage.translatesAutoresizingMaskIntoConstraints = false
        return parkingImage
    }()
    
    var goalExcuseTextAndDescription: UITextView = {
        var textView = UITextView()
        
        let titleText = NSMutableAttributedString(string: "Do you have goals??", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        let subtitleText = NSMutableAttributedString(string: "\n\n\nAre you a person who constantly strives to achieve something important in life?", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
        titleText.append(subtitleText)
        textView.attributedText = titleText
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    var prevButton: UIButton = {
        var preButton = UIButton()
        let subtitleText = NSMutableAttributedString(string: "PREV", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.gray])
        preButton.setAttributedTitle(subtitleText, for: .normal)
        return preButton
    }()
    
    var nextButton: UIButton = {
        var nxtButton = UIButton()
        let subtitleText = NSMutableAttributedString(string: "NEXT", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        nxtButton.setAttributedTitle(subtitleText, for: .normal)
        return nxtButton
    }()
    
    var pageControl: UIPageControl =  {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = UIColor.black
        pc.pageIndicatorTintColor = UIColor.lightGray
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        setupUIOnTheScreen()
    }
    
    private func setupUIOnTheScreen() {
        
        var imageView = UIView()
        imageView.addSubview(goalExcuseImage)
        
        var descriptionView = UIView()
        descriptionView.addSubview(goalExcuseTextAndDescription)
        
        var bottomStackView = UIStackView(arrangedSubviews: [prevButton,pageControl,nextButton])
        bottomStackView.distribution = .fillEqually
        bottomStackView.axis = .horizontal
        
        var stackView = UIStackView(arrangedSubviews: [imageView,descriptionView,bottomStackView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.leftAnchor.constraint(equalTo: view.leftAnchor), stackView.rightAnchor.constraint(equalTo: view.rightAnchor), stackView.topAnchor.constraint(equalTo: view.topAnchor), stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        goalExcuseImage.contentMode = .scaleAspectFit
        goalExcuseImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        goalExcuseImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        goalExcuseImage.heightAnchor.constraint(equalTo: bottomStackView.heightAnchor).isActive = true
        goalExcuseImage.widthAnchor.constraint(equalTo: bottomStackView.widthAnchor).isActive = true
        
        goalExcuseTextAndDescription.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 50).isActive = true
        goalExcuseTextAndDescription.rightAnchor.constraint(equalTo: descriptionView.rightAnchor, constant: -5).isActive = true
        goalExcuseTextAndDescription.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: 5).isActive = true
        goalExcuseTextAndDescription.textAlignment = .center
        
    }
}

