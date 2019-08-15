//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerEconomy: UIViewController {

    @IBOutlet weak var economyDescription: UILabel!
    @IBOutlet weak var wealthCounter: UILabel!
    @IBOutlet weak var citizenWealthCounter: UILabel!
    @IBOutlet weak var incomeCounter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        wealthCounter.text = String(Civilization.shared.wealth)
        citizenWealthCounter.text = String(Civilization.shared.avgCitizenWealth())
        incomeCounter.text = String(Civilization.shared.getIncome())
    }
}
