//
//  GovProgram.swift
//  Legislate
//
//  Created by Casey Manning on 8/31/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation

class GovProgram : Equatable {
    
    var name: String
    var description: String
    var effect: (() -> ())
    var effects: [Effect]
    
    init(name: String, description: String, effect: @escaping (() -> ()), effects: [Effect]) {
        self.name = name
        self.effect = effect
        self.effects = effects
        self.description = description
    }
    
    func getString() -> String {
        return name
    }
    
    static func taxationEffect() {
        Civilization.shared.wealth += Civilization.shared.getTaxAmount()
    }
    
    static func getPrograms() -> [GovProgram] {
        let progs = [
        
            GovProgram(name: "Taxation", description: "Requires everyone in your civilization to give a percentage of their income to the government. This policy gives 1 unrest, and each turn, you will recieve 10% of each tax-paying citizens' income.", effect: taxationEffect, effects: [Effect(affects: "unrest", amount: 1, expiry: 10000, cause: "Taxation", percent: 0)]),

            GovProgram(name: "Test 1", description: "Requires everyone in your civilization to give a percentage of their income to the government. This policy gives 1 unrest, and each turn, you will recieve 10% of each tax-paying citizens' income.", effect: taxationEffect, effects: [Effect(affects: "unrest", amount: 1, expiry: 10000, cause: "Taxation", percent: 0)]),

            GovProgram(name: "Test 2", description: "Requires everyone in your civilization to give a percentage of their income to the government. This policy gives 1 unrest, and each turn, you will recieve 10% of each tax-paying citizens' income.", effect: taxationEffect, effects: [Effect(affects: "unrest", amount: 1, expiry: 10000, cause: "Taxation", percent: 0)])

        ]

        return progs

    }
    
    static func fromString(pname: String) -> GovProgram? {
        for program in Civilization.shared.possiblePograms {
            if program.name == pname {
                return program
            }
        }
        return nil
    }
    
    static func == (a: GovProgram, b: GovProgram) -> Bool {
        return a.name == b.name && a.description == b.description
    }
}

