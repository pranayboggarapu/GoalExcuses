//
//  OnboardingPageData.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/7/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import Foundation

struct OnboardingPageData {
    let totalData: [PageSpecificData]
     
    init() {
        totalData = {
            return [PageSpecificData(imageName: "firstGoalExcuseOnboardingImage", headerText: "Do you have goals??",                                                                                              descriptionText: "Are you a person who constantly strives to achieve something important in life?"),
                    PageSpecificData(imageName: "secondGoalExcuseOnboardingImage", headerText: "Do you give excuses?",                                                                             descriptionText: "Are you tired of giving excuses to yourself thereby not achieving your goal?"),
                    PageSpecificData(imageName: "thirdGoalExcuseOnboardingImage", headerText: "Do you need help from your own friends?",                                                                             descriptionText: "Are you feeling that a friend can decipher when you can give an excuse and push you to the goal"),
                    PageSpecificData(imageName: "fourthGoalExcuseOnboardingImage", headerText: "This app is exactly for that purpose",                                                                             descriptionText: "Create a goal, share it with your friends. Let them help you achieve your goal")
            ]
        }()
    }
}

struct PageSpecificData {
    let imageName: String
    let headerText: String
    let descriptionText: String
}
