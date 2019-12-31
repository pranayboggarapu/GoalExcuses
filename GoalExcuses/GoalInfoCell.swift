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
        textView.isUserInteractionEnabled = false
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
        textView.isUserInteractionEnabled = false
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
        textView.isUserInteractionEnabled = false
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    var sharedWithTextView: UITextView = {
        var textView = UITextView()
        textView.text = "Shared with : "
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.boldSystemFont(ofSize: 12)
        textView.isScrollEnabled = false
        return textView
    }()
    
    var creatorTextView: UITextView = {
        var textView = UITextView()
        textView.text = "Creator : "
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.font = UIFont.boldSystemFont(ofSize: 12)
        textView.isScrollEnabled = false
        return textView
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let firstLineStackView = UIStackView(arrangedSubviews: [goalName,goalCreatedDate])
        firstLineStackView.axis = .horizontal
        firstLineStackView.distribution = .equalSpacing
        firstLineStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let overallStackView = UIStackView(arrangedSubviews: [firstLineStackView,goalDescription, creatorTextView, sharedWithTextView])
        overallStackView.axis = .vertical
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overallStackView)
        
        NSLayoutConstraint.activate([overallStackView.leftAnchor.constraint(equalTo: self.leftAnchor), overallStackView.rightAnchor.constraint(equalTo: self.rightAnchor), overallStackView.topAnchor.constraint(equalTo: self.topAnchor), overallStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        NSLayoutConstraint.activate([firstLineStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
                                     firstLineStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40)])
    }
    
}
