//
//  Citizen.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/13/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation

struct Citizen {
    
    var religion = "Atheist"
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
        
        return Citizen(religion: "Atheist", occupation: "Farmers")
    }
}
