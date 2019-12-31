//
//  AppDelegate.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/7/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let defaults = UserDefaults.standard
        
        guard (!(defaults.object(forKey: "hideOnboarding") == nil) || defaults.bool(forKey: "hideOnboarding")) else {
            defaults.set(true, forKey: "hideOnboarding")
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let swipingController = OnboardingCollectionController(collectionViewLayout: layout)
            window?.rootViewController = swipingController
            return true
        }
        
        let viewController = FacebookLoginViewController()
        window?.rootViewController = viewController
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
}

