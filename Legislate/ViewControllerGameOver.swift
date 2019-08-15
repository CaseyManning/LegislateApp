//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerGameOver: UIViewController {
    
    
    @IBOutlet weak var turnsText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        turnsText.text = "Your rule lasted " + String(Civilization.shared.turn) + " turns."
    }
}
