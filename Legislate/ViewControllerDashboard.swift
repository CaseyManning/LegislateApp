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
    @IBOutlet weak var turnNum: UILabel!
    
    @IBOutlet weak var civilizationMarkerLabel: UILabel!
    
    @IBOutlet weak var militaryButton: UIButton!
    override func viewDidLoad() {
        print("Loading Dashboard View")
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        
        let defaults = UserDefaults.standard
        defaults.set("true", forKey: "started")
        
        
        Civilization.shared.update()
        Civilization.shared.unrest -= 1
        Civilization.shared.unrest += 1
        Civilization.shared.calculateUnrest()
        surplusNum.text = String(Int(Civilization.shared.wealth))
        populationNum.text = String(Int(Civilization.shared.population.count))
        unrestNum.text = String(Int(Civilization.shared.unrest))
        povertyNum.text = String(Int(Civilization.shared.poverty))
        
        civilizationMarkerLabel.text = Civilization.shared.name
        
        turnNum.text = "Turn: " + String(Civilization.shared.turn)
        if Civilization.shared.unrest > 10 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameOverScreen") as!ViewControllerDashboard
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func endTurnPressed(_ sender: Any) {
        
    }
    
    func renderMap() {
        
    }
}
