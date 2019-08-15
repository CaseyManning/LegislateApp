//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit

    
class ViewControllerModifiers: UIViewController {
    
    @IBOutlet weak var placeholderText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        
        let effects = Civilization.shared.effects
        
        for i in 0..<effects.count {
            let x = view.center.x - placeholderText.bounds.width/2
            let y = placeholderText.bounds.minY + CGFloat(i*50)
            let modifierLabel = UILabel(frame: CGRect(x: x, y: y, width: placeholderText.bounds.width, height: placeholderText.bounds.width))
            modifierLabel.text = String(effects[i].amount) + " " + effects[i].affectedField + " from " + effects[i].cause
            modifierLabel.font = placeholderText.font
            modifierLabel.textAlignment = .center
            
            view.addSubview(modifierLabel)
        }
        
    }   
}
