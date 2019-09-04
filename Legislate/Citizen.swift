//
//  Citizen.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/13/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation

struct Citizen {
    
    var religion = Civilization.religions[0]
    var wealth: Double = 1
    var unrest = 0.0
    var occupation = "Farmers"
    var gender: String
    
    init(religion: String, occupation: String) {
        self.religion = religion
        self.occupation = occupation
        self.gender = ["Men", "Women"][Int.random(in: 0..<2)]
    }
    
    static func generateCitizen() -> Citizen {
        
        let religion = Civilization.religions[Int.random(in: 0..<Civilization.religions.count)]
        
        return Citizen(religion: religion, occupation: "Farmers")
    }
    
    mutating func calcWealth() {
        if occupation == "Farmers" {
            self.wealth = 1.0
        } else if occupation == "Artisans" {
            self.wealth = 1.5
        } else if occupation == "Merchants" {
            self.wealth = 5.0
        }
    }
}
