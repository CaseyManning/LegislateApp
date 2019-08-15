//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerSpecificLaw: UIViewController {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    
    
    @IBOutlet weak var effect1: UILabel!
    @IBOutlet weak var effect2: UILabel!
    @IBOutlet weak var effect3: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        let law = Civilization.shared.currentLaw
        titleText.text = law!.generateLawString()
        descriptionText.text = law!.getLawDesc()
        
        let labels = [effect1, effect2, effect3]
        
        let effects = law!.getEffects()
        
        for i in 0..<effects.count {
            labels[i]!.isHidden = false
            labels[i]!.text = effects[i].generateString()
        }
    }
    @IBAction func repealPressed(_ sender: Any) {
        Civilization.shared.laws.remove(at: Civilization.shared.laws.firstIndex{$0 == Civilization.shared.currentLaw!}!)
    }
}
