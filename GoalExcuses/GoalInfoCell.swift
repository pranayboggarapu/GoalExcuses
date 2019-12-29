//
//  GoalInfoCell.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/16/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import UIKit

class GoalInfoCell: UITableViewCell {
    
    var goalDescription: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.italicSystemFont(ofSize: 12)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var goalName: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.boldSystemFont(ofSize: 14)
        return textView
    }()
    
    var goalCreatedDate: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textAlignment = .right
        return textView
    }()
    
    var sharedWithTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        var firstLineStackView = UIStackView(arrangedSubviews: [goalName,goalCreatedDate])
        firstLineStackView.axis = .horizontal
        firstLineStackView.distribution = .equalSpacing
        firstLineStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
//        let subtitleText = NSAttributedString(string: "\n\n\n\(page.descriptionText)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
//        let headerText = NSAttributedString(string: page.headerText, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
//        let mutableAttributedString = NSMutableAttributedString(attributedString: headerText)
//        mutableAttributedString.append(subtitleText)
//        goalExcuseTextAndDescription.attributedText = mutableAttributedString
        
//        var stackView = UIStackView(arrangedSubviews: [firstLineStackView,goalDescription])
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
        
        var overallStackView = UIStackView(arrangedSubviews: [firstLineStackView,goalDescription, sharedWithTextView])
        overallStackView.axis = .vertical
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overallStackView)
        
        NSLayoutConstraint.activate([overallStackView.leftAnchor.constraint(equalTo: self.leftAnchor), overallStackView.rightAnchor.constraint(equalTo: self.rightAnchor), overallStackView.topAnchor.constraint(equalTo: self.topAnchor), overallStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        NSLayoutConstraint.activate([firstLineStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                                     firstLineStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40)])
        
//        NSLayoutConstraint.activate([firstLineStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
//                                    firstLineStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)])
        
//        NSLayoutConstraint.activate([goalDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
//                                     goalDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
//                                     goalDescription.topAnchor.constraint(equalTo: firstLineStackView.bottomAnchor, constant: 20),
//                                     goalDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20)])
    }
    
}
