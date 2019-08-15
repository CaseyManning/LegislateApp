//
//  Event.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/12/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation

struct Event {
    
    var name: String
    var options: Dictionary<String, [Effect]>
    var description: String
    var requirement: (() -> Bool)
    var inevitable: Bool
    static var allEvents: [Event] = []
    
    init(name: String, description: String, options: Dictionary<String, [Effect]>, requirement: @escaping () -> Bool, inevitable: Bool) {
        self.name = name
        self.options = options
        self.description = description
        self.requirement = requirement
        self.inevitable = inevitable
    }
    
    static func createEvents() {
        
        let options1 =  [
            "Excellent!": [Effect(affects: "unrest", amount: -1, expiry: 3, cause: "A Good Harvest", percent: 0)],
            "Extra food belongs to the state!": [Effect(affects: "wealth", amount: 6, expiry: 1, cause: "A Good Harvest", percent: 0), Effect(affects: "unrest", amount: 1, expiry: 10, cause: "Surplus Proceeds confiscated", percent: 0)]]
        
        let event1 = Event(name: "A Bountiful Harvest", description: "The gods have been kind this year, and our civilization has brought in a bountiful harvest.", options: options1, requirement: {return true}, inevitable: false)
        
        allEvents.append(event1)
        
        let options2 =  [
            "They can fend for themselves": [Effect(affects: "unrest", amount: 3, expiry: 3, cause: "A Failed Harvest", percent: 0), Effect(affects: "population", amount: -5, expiry: 1, cause: "A Failed Harvest", percent: 0)],
            "Give food from our stores": [Effect(affects: "wealth", amount: -10, expiry: 1, cause: "A Failed Harvest", percent: 0), Effect(affects: "unrest", amount: 1, expiry: 5, cause: "A Failed Harvest", percent: 0)]]
        
        let event2 = Event(name: "Failed Harvest", description: "The gods have not been merciful this year, and much of our crop harvest failed. Our citizens will go hungry unless we intervene.", options: options2, requirement: {return true}, inevitable: false)

        allEvents.append(event2)
        
        let options3 =  [
            "Allow them in": [Effect(affects: "unrest", amount: 1, expiry: 10, cause: "Religious Immigrants", percent: 0), Effect(affects: "population", amount: 10, expiry: 1, cause: "Religious Immigrants", percent: 0)],
            "Turn them away": []
        ]
        
        let event3 = Event(name: "Religious Immigrants", description: "A new religious group has arrived at our borders seeking entry. However, the religion they all follow isn't accepted by our society, and may cause divisions.", options: options3, requirement: {return true}, inevitable: false)
        
        allEvents.append(event3)
        
        let options4 =  [
            "Appease them with donations": [Effect(affects: "wealth", amount: -15, expiry: 1, cause: "generous donations", percent: 0), Effect(affects: "unrest", amount: -2, expiry: 5, cause: "generous donations", percent: 0)],
            "Ignore them": [Effect(affects: "unrest", amount: 1, expiry: 10, cause: "ignored riots", percent: 0)]
        ]
        
        let event4 = Event(name: "Rioting in the streets", description: "Many people are unhappy with your rule, and have taken to the streets in protest", options: options4, requirement: {return Civilization.shared.unrest > 0}, inevitable: true)
        
        allEvents.append(event4)
        
        let options5 =  [
            "Levy emergency taxes": [Effect(affects: "wealth", amount: +15, expiry: 1, cause: "emergency taxes", percent: 0), Effect(affects: "unrest", amount: 5, expiry: 10, cause: "emergency taxes", percent: 0)],
            "Who cares?": []
        ]
        
        let event5 = Event(name: "Bankruptcy!", description: "The treasury is empty, and we are in desperate need of more money", options: options5, requirement: {return Civilization.shared.wealth < 0}, inevitable: true)
        
        allEvents.append(event5)
    }
}
