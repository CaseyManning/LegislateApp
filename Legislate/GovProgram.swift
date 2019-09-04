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
    var effect: (([String]) -> ())
    var effects: [Effect]
    
    var affectedGroups: [String] = [
    "Everyone"]
    
    init(name: String, description: String, effect: @escaping (([String]) -> ()), effects: [Effect]) {
        self.name = name
        self.effect = effect
        self.effects = effects
        self.description = description
    }
    
    func getString() -> String {
        return name
    }
    
    static func taxationEffect(groups: [String]) {
        print("Levying Taxes")
        print(groups)
        var income: Double = 0
        for c in Civilization.shared.population {
            if isIncluded(person: c, affectedGroups: groups) {
                income += c.wealth * Civilization.shared.taxRate
            }
        }
        Civilization.shared.wealth += income
    }
    
    static func welfareEffect(groups: [String]) {
        for i in 0..<Civilization.shared.population.count {
            var cit = Civilization.shared.population[i]
            if cit.wealth < 0.75 && isIncluded(person: cit, affectedGroups: groups){
                Civilization.shared.wealth = 0.75 - cit.wealth
                cit.wealth = 0.75
            }
        }
    }
    
    static func subsidiesEffect(groups: [String]) {
        print("Subsidizing")
        for i in 0..<Civilization.shared.population.count {
            let cit = Civilization.shared.population[i]
            if isIncluded(person: cit, affectedGroups: groups) {
                Civilization.shared.wealth -= 0.1
            }
        }
    }
    
    static func isIncluded(person: Citizen, affectedGroups: [String]) -> Bool {
        return affectedGroups.contains(person.occupation) || affectedGroups.contains(person.religion) || affectedGroups.contains(person.gender) || affectedGroups.contains("Everyone")
    }
    
    static func getPrograms() -> [GovProgram] {
        let progs = [
        
            GovProgram(name: "Taxation", description: "Requires everyone in your civilization to give a percentage of their income to the government. This policy gives 1 unrest, and each turn, you will recieve 10% of each tax-paying citizens' income.", effect: taxationEffect, effects: [Effect(affects: "unrest", amount: 1, expiry: 10000, cause: "Taxation", percent: 0)]),

            GovProgram(name: "Welfare", description: "Provides money to citizens below the poverty line. This will reduce unrest from poverty but may be quite costly. Gives money to all citizens below 0.75 wealth such that they have exactly 0.75 wealth, giving them no unrest.", effect: welfareEffect, effects: []),

            GovProgram(name: "Subsidies", description: "Sometimes you just need a little extra cash, directly from the government. This program gives 0.1 wealth to all citizens it effects, which will be subtracted from your income each turn.", effect: subsidiesEffect, effects: [Effect(affects: "unrest", amount: -1, expiry: 10000, cause: "Subsidies", percent: 0), Effect(affects: "citizen wealth", amount: 0.1, expiry: 10000, cause: "Subsidies", percent: 0)])

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

