//
//  FacebookClient.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/15/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class FacebookClient {
    
    class func loginAndFetchUserDetails(viewController: UIViewController, completionHandler: @escaping (Bool, FBUserData?, Error?) -> Void) {
        var userData: FBUserData?
        LoginManager().logIn(permissions: ["email","public_profile"], from: viewController) { (result, err) in
            if err != nil {
                print("FB Login failed:", err)
                completionHandler(false,nil,err)
            } else {
                let request = GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
                    if err != nil {
                        print("FB Data Query failed:", err)
                        completionHandler(false,nil,err)
                    } else {
                        print(result)
                        let formattedResult = result! as! [String: String]
                        userData = FBUserData(emailId: formattedResult["email"]!, name: formattedResult["name"]!, id: formattedResult["id"]!)
                        completionHandler(true,userData,nil)
                    }
                }
            }
        }
    }
    
}
