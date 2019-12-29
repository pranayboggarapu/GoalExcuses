//
//  OnboardingCollectionViewCell.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/7/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    var pageData: PageSpecificData? {
        didSet {
            guard let page = pageData else { return }
            goalExcuseImage.image = UIImage(named: page.imageName)
            let subtitleText = NSAttributedString(string: "\n\n\n\(page.descriptionText)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
            let headerText = NSAttributedString(string: page.headerText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            let mutableAttributedString = NSMutableAttributedString(attributedString: headerText)
            mutableAttributedString.append(subtitleText)
            goalExcuseTextAndDescription.attributedText = mutableAttributedString
            goalExcuseTextAndDescription.textAlignment = .center
        }
    }
    
    var goalExcuseImage: UIImageView = {
        var parkingImage = UIImageView()
        parkingImage.translatesAutoresizingMaskIntoConstraints = false
        return parkingImage
    }()
    
    var goalExcuseTextAndDescription: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupUIOnTheScreen()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUIOnTheScreen() {
        
        let imageView = UIView()
        imageView.addSubview(goalExcuseImage)
        
        let descriptionView = UIView()
        descriptionView.addSubview(goalExcuseTextAndDescription)
                
        let stackView = UIStackView(arrangedSubviews: [imageView,descriptionView,UIView()])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        NSLayoutConstraint.activate([stackView.leftAnchor.constraint(equalTo: self.leftAnchor), stackView.rightAnchor.constraint(equalTo: self.rightAnchor), stackView.topAnchor.constraint(equalTo: self.topAnchor), stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        goalExcuseImage.contentMode = .scaleAspectFit
        goalExcuseImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        goalExcuseImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        goalExcuseImage.heightAnchor.constraint(equalTo: descriptionView.heightAnchor).isActive = true
        goalExcuseImage.widthAnchor.constraint(equalTo: descriptionView.widthAnchor).isActive = true
        
        goalExcuseTextAndDescription.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 50).isActive = true
        goalExcuseTextAndDescription.rightAnchor.constraint(equalTo: descriptionView.rightAnchor, constant: -5).isActive = true
        goalExcuseTextAndDescription.leftAnchor.constraint(equalTo: descriptionView.leftAnchor, constant: 5).isActive = true
        goalExcuseTextAndDescription.textAlignment = .center
        
    }
    
}
