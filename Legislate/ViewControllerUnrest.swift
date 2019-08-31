//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerUnrest: UIViewController {
    
    @IBOutlet weak var unrestNum: UILabel!
    
    @IBOutlet weak var baseUnrest: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ViewController.backgroundColor
        Civilization.shared.calculateUnrest()
        unrestNum.text = String(Civilization.shared.unrest)
        
//        baseUnrest.text = "This is the average unrest of all of your citizens"
        
        var unrestMods: [Effect] = []
        for mod in Civilization.shared.effects {
            if mod.affectedField == "unrest" && mod.amount != 0 {
                unrestMods.append(mod)
            }
        }
        for law in Civilization.shared.laws {
            for mod in law.getEffects() {
                if mod.affectedField == "unrest" && mod.amount != 0 {
                    unrestMods.append(mod)
                }
            }
        }
        for i in 0..<unrestMods.count {
            let x = view.center.x - 250
            let y = Int(baseUnrest.frame.minY) + (i*33) + 70
            let effectLabel = UILabel(frame: CGRect(x: Int(x), y: y, width: 500, height: 20))
            effectLabel.text = String(unrestMods[i].amount) + " unrest from " + unrestMods[i].cause
            effectLabel.font = baseUnrest.font
            effectLabel.textAlignment = .center
            if unrestMods[i].amount < 0 {
                effectLabel.textColor = UIColor(displayP3Red: 0, green: 0.5, blue: 0, alpha: 1)
            } else {
                effectLabel.textColor = UIColor(displayP3Red: 1, green: 0.1, blue: 0.1, alpha: 1)
            }
            view.addSubview(effectLabel)
        }
        
        
        unrestNum.text = String(Civilization.shared.unrest)
    }
}
