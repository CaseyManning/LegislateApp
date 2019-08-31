//
//  Modifier.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/12/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation


struct Effect {
    var affectedField = ""
    var amount: Double = 0.0
    var expiry = 1000
    
    static let all = ["Everyone"]
    
    var cause = ""
    var percent = 0
    var affectedGroups: [String] = []
    init(affects: String, amount: Double, expiry: Int, cause: String, percent: Int, affectedGroups: [String]) {
        affectedField = affects
        self.amount = amount
        self.expiry = expiry
        self.cause = cause
        self.percent = percent
        self.affectedGroups = affectedGroups
    }
    
    init(affects: String, amount: Double, expiry: Int, cause: String, percent: Int) {
        affectedField = affects
        self.amount = amount
        self.expiry = expiry
        self.cause = cause
        self.percent = percent
        self.affectedGroups = Effect.all
    }
    
    func generateString() -> String {
        if percent == 0 {
            if affectedField == "population" || affectedField == "wealth" {
                return "Gives " + String(amount) + " " + affectedField + " per turn."
            } else {
                if affectedGroups == Effect.all || affectedGroups.count < 1 {
                    return "Gives " + String(amount) + " " + affectedField + "."
                } else {
                    return "Gives " + String(amount) + " " + affectedField + " for " + affectedGroups[0] + "."
                }
            }
        } else {
            if percent < 0 {
                return "Gives " + String(percent) + " " + affectedField + "."
            } else {
                return "Gives " + String(percent) + "% more " + affectedField + "."
            }
        }
    }
    
    func affects(citizen: Citizen) -> Bool {
        print(affectedGroups)
        print(citizen.religion)
        return affectedGroups.contains("Everyone") || affectedGroups.contains(citizen.occupation) || affectedGroups.contains(citizen.gender) || affectedGroups.contains(citizen.religion)
    }
}
