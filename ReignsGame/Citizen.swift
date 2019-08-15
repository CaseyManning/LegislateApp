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
    var occupation = "Farming"
    
    init(faith: String, occupation: String) {
        
    }
    
    static func generateCitizen() -> Citizen {
        
        return Citizen(faith: "dumb", occupation: "farming")
    }
}
