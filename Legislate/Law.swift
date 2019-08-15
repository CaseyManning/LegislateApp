//
//  Law.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/13/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation

struct Law {
    
    var action: String
    var forGroup: String
    var type: String
    
    static var laws = ["Murder", "Theft", "Firearms", "Religious Gatherings", "All Religious Practice", "Criticism of the Government", "Medical Care", "Private Property", "Personal Wealth", "Farming", "Nonagricultural Jobs", "Land Ownership"]
    
    static let descriptions = [
        "Ban of Murder": "A cornerstone of legal systems across the globe, this anti-homocide legislation ensures that regular citizens don't go around killing each other willy-nilly.",
        "Ban of Murder for Men": "Many of the less forward-thinking citizens in your realm consider the idea of murder being illegal only for men to be completely ludicrous, causing significant unrest.",
        "Ban of Murder for Women": "Many of the less forward-thinking citizens in your realm consider the idea of murder being illegal only for women to be completely ludicrous, causing significant unrest.",
        "Ban of Murder for Farmers": "Many of the less forward-thinking citizens in your realm consider the idea of murder being illegal only for artisans to be completely ludicrous, causing significant unrest.",
        "Ban of Murder for Artisans": "Many of the less forward-thinking citizens in your realm consider the idea of murder being illegal only for artisans to be completely ludicrous, causing significant unrest.",
        "Ban of Theft": "Prevents any citizen from taking the possessions of any other citizen without their consent."
    ]
    static let effects = [
        "Ban of Murder": [
            Effect(affects: "unrest", amount: -3, expiry: 10000, cause: "Ban on Murder", percent: 0),
            Effect(affects: "population", amount: 1, expiry: 10000, cause: "Ban on Murder", percent: 0)
        ],
        "Ban of Murder for Men": [
            Effect(affects: "unrest", amount: 1, expiry: 10000, cause: "Ban on Murder", percent: 0),
        ],
        "Ban of Murder for Women": [
            Effect(affects: "unrest", amount: 1, expiry: 10000, cause: "Ban on Murder", percent: 0),
        ],
        "Ban of Murder for Farmers": [
            Effect(affects: "unrest", amount: 1, expiry: 10000, cause: "Ban on Murder", percent: 0),
        ],
        "Ban of Murder for Artisans": [
            Effect(affects: "unrest", amount: 1, expiry: 10000, cause: "Ban on Murder", percent: 0),
        ],
        "Ban of Theft": [
            Effect(affects: "unrest", amount: -1, expiry: 10000, cause: "Ban on Theft", percent: 0),
            Effect(affects: "citizen wealth", amount: 0.1, expiry: 10000, cause: "Ban on Theft", percent: 0)
        ],
        "Ban of Medical Care": [
            Effect(affects: "population", amount: -2, expiry: 10000, cause: "Ban on Medical Care", percent: 0),
            Effect(affects: "unrest", amount: 4, expiry: 10000, cause: "Ban on Medical Care", percent: 0)
        ],
        "Ban of Medical Care for ": [
            Effect(affects: "population", amount: -1.0, expiry: 10000, cause: "Ban on Medical Care", percent: 0),
            Effect(affects: "unrest", amount: 6.0, expiry: 10000, cause: "Ban on Medical Care", percent: 0, affectedGroups: ["Poor People"])
        ]
    ]
    
    init(type: String, action: String, forGroup: String) {
        self.type = type
        self.action = action
        self.forGroup = forGroup
    }
    
    func generateLawString() -> String {
        var buttonText = ""
        if type == "Ban" {
            buttonText += "Ban of "
        } else {
            buttonText += "Legalization of "
        }
        buttonText += action
        if forGroup != "Everyone" {
            buttonText += " for " + forGroup
        }
        return buttonText
    }
    
    func getLawDesc() -> String {
        return Law.descriptions[generateLawString()] ?? "No description for this law yet"
    }
    
    func getEffects() -> [Effect] {
        return Law.effects[generateLawString()] ?? []
    }
    
    static func == (a: Law, b: Law) -> Bool {
        return a.action == b.action && a.forGroup == b.forGroup && a.type == b.type
    }
}
