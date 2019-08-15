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
        "Ban of Murder for Poor People": "Many of the less forward-thinking citizens in your realm consider the idea of murder being illegal only for poor people to be completely ludicrous, causing significant unrest.",
        "Ban of Murder for Rich People": "Many of the less forward-thinking citizens in your realm consider the idea of murder being illegal only for rich people to be completely ludicrous, causing significant unrest.",
        "Ban of Theft": "Central to all capitalist systems is the idea that individuals can accrue personal wealth with the protection of the state. One such protection is that no part of someone's wealth may be stolen by anyone else.",
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
        "Ban of Murder for Poor People": [
            Effect(affects: "unrest", amount: 1, expiry: 10000, cause: "Ban on Murder", percent: 0),
        ],
        "Ban of Murder for Rich People": [
            Effect(affects: "unrest", amount: 1, expiry: 10000, cause: "Ban on Murder", percent: 0),
        ],
        "Ban of Theft": [
            Effect(affects: "unrest", amount: -1, expiry: 10000, cause: "Ban on Theft", percent: 0),
            Effect(affects: "citizen wealth", amount: 0.1, expiry: 10000, cause: "Ban on Theft", percent: 0)
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
