//
//  UserData.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/15/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation

struct FBUserData: Codable {
    var emailId: String
    var name: String
    var id: String
    
    
    enum CodingKeys: String, CodingKey {
        case emailId = "email"
        case name = "name"
        case id = "id"
    }
}

