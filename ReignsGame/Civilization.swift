//
//  Civilization.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/12/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation

class Civilization {
    static let shared = Civilization()
    
    var wealth = 1.0
    var population : [Citizen] = []
    var unrest = 1.0
    var poverty = 1.0
    
    var laws: [Law] = []
    
    var name = "Unamed Civilization"
    
    var currentLaw: Law? = nil
    
    var civilizationType = "Agrarian Commune"
    
    var effects: [Effect] = []
    
    func calculateUnrest() {
        
        unrest = getWeightedUnrest()
        
        for law in laws {
            for mod in law.getEffects() {
                if mod.affectedField == "unrest" {
                    unrest *= Double(1 + Double(mod.percent)/100.0)
                }
            }
        }
        print("Unrest:" + String(unrest))
    }
    
    func getBaseUnrest() -> Double {
        var u = 0.0
        for c in population {
            u += c.unrest
        }
        u /= Double(population.count)
        return u
    }
    
    func getWeightedUnrest() -> Double {
        var u = 0.0
        for c in population {
            u += c.unrest * Double(c.wealth)
        }
        u /= Double(population.count)
        return u
    }
    
    func getIncome() -> Double {
        return 2
    }
    
    func applyModifiers() {
        for effect in effects {
            if effect.affectedField == "wealth" {
                print("Changing wealth by " + String(effect.amount))
                wealth += effect.amount
            }
            if effect.affectedField == "population" {
                if effect.amount > 0 {
                    for _ in 0..<Int(effect.amount) {
                        population.append(Citizen.generateCitizen())
                    }
                } else {
                    for _ in 0..<Int(abs(effect.amount)) {
                        population.remove(at: Int.random(in: 0..<population.count))
                    }
                }
            }
        }
        
        for law in laws {
            for effect in law.getEffects() {
                if effect.affectedField == "wealth" {
                    wealth += effect.amount
                }
                if effect.affectedField == "population" {
                    wealth += effect.amount
                }
            }
        }
    }
    
    func tickModifiers() {
        if effects.count > 0 {
            for i in 0..<effects.count-1 {
                effects[i].expiry -= 1
                if effects[i].expiry <= 0 {
                    effects.remove(at: i)
                }
            }
        }
    }
    
    func avgCitizenWealth() -> Double {
        var sum: Double = 0
        for c in population {
            sum += c.wealth
        }
        return sum / Double(population.count)
    }
    
    func update() {
        calculateUnrest()
        
        for i in 0..<population.count {
            population[i].unrest = 0
            for effect in effects{
                if effect.affectedField == "unrest" {
                    if effect.affects(citizen: population[i]) {
                        population[i].unrest += effect.amount
                    }
                }
            }
            for l in laws {
                for effect in l.getEffects(){
                    if effect.affectedField == "unrest" {
                        if effect.affects(citizen: population[i]) {
                            population[i].unrest += effect.amount
                        }
                    }
                }
            }
        }
    }
    
    func nextTurn() {
        wealth += getIncome()
        Civilization.shared.applyModifiers()
        tickModifiers()
    }
}
