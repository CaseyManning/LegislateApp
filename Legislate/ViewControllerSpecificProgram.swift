//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerSpecificProgram: UIViewController {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        titleText.text = Civilization.shared.currentProgram?.name
        descriptionLabel.text = Civilization.shared.currentProgram?.description
    }
    @IBAction func removePressed(_ sender: Any) {
        Civilization.shared.programs.remove(at: Civilization.shared.programs.firstIndex(of: Civilization.shared.currentProgram!)!)
    }
}
