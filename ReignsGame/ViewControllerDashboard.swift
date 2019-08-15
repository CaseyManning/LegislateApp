//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerDashboard: UIViewController {

    @IBOutlet weak var povertyButton: UIButton!
    @IBOutlet weak var unrestButton: UIButton!
    @IBOutlet weak var surplusButton: UIButton!
    @IBOutlet weak var populationButton: UIButton!
    
    @IBOutlet weak var surplusNum: UILabel!
    @IBOutlet weak var populationNum: UILabel!
    @IBOutlet weak var unrestNum: UILabel!
    @IBOutlet weak var povertyNum: UILabel!
    
    @IBOutlet weak var civilizationMarkerLabel: UILabel!
    
    @IBOutlet weak var militaryButton: UIButton!
    override func viewDidLoad() {
        print("Loading Dashboard View")
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        
        let defaults = UserDefaults.standard
        defaults.set("true", forKey: "started")
        
        let civ = Civilization.shared
        Civilization.shared.update()
        
        surplusNum.text = String(Int(civ.wealth))
        populationNum.text = String(Int(civ.population.count))
        unrestNum.text = String(Int(civ.unrest))
        povertyNum.text = String(Int(civ.poverty))
        
        civilizationMarkerLabel.text = Civilization.shared.name
    }
    
    @IBAction func endTurnPressed(_ sender: Any) {
        
    }
    
    func renderMap() {
        
    }
}
