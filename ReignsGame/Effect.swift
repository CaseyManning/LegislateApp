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
    
    static let all = ["Rich People", "Poor People"]
    
    var cause = ""
    var percent = 0
    var affectedGroups: [String] = []
    init(affects: String, amount: Double, expiry: Int, cause: String, percent: Int, affectedGroups: [String]) {
        affectedField = affects
        self.amount = amount
        self.expiry = expiry
        self.cause = cause
        self.percent = percent
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
                return "Gives " + String(amount) + " " + affectedField + "."
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
        return true
    }
}
