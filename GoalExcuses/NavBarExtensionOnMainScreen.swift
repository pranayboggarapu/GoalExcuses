//
//  NavBarExtension.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/16/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addNavBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LOGOUT", style: .done, target: self, action: #selector(logOutButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 64/255, green: 128/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let addButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addButtonPressed))
        addButtonItem.tintColor = UIColor(red: 64/255, green: 128/255, blue: 255/255, alpha: 1.0)
        navigationItem.rightBarButtonItems = [addButtonItem]
    }
    
    @objc func logOutButtonPressed() {
        print("Logout Button Pressed")
    }
    
    @objc func addButtonPressed() {
        print("Add Button Pressed")
    }
}

extension UIViewController {
    //Display error message - generic method
    func displayErrorMessage(errorTitle: String, errorMessage: String) {
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
