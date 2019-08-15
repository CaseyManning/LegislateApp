//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerTurnEvent: UIViewController {
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    
    @IBOutlet weak var option1Effects: UILabel!
    @IBOutlet weak var option2Effects: UILabel!
    @IBOutlet weak var option3Effects: UILabel!
    
    var modifierList: [[Effect]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        Event.createEvents()
        
        let event = chooseEvent()
        eventTitle.text = event.name
        eventDescription.text = event.description
        
        let optionButtons = [option1Button, option2Button, option3Button]
        let optionEffects = [option1Effects, option2Effects, option3Effects]
        
        let optionArray = Array(event.options.keys)
        
        for i in 0..<optionArray.count {
            optionButtons[i]?.isHidden = false
            optionButtons[i]?.setTitle(optionArray[i], for: .normal)

            
            var effectsString = "Gives "
            modifierList.append([])
            for mod in event.options[optionArray[i]]! {
                modifierList[i].append(mod)
                effectsString += String(mod.amount) + " " + mod.affectedField
                if mod.expiry > 1 {
                    effectsString += " for " + String(mod.expiry) + " turns"
                }
                effectsString += " and "
            }
            
            let index = effectsString.index(effectsString.endIndex, offsetBy: -5)
            effectsString = String(effectsString.prefix(upTo: index))
            effectsString += "."
            if event.options[optionArray[i]]!.count > 0 {
                optionEffects[i]?.isHidden = false
            }
            optionEffects[i]!.text = effectsString
        }
        
        
    }
    
    func chooseEvent() -> Event {
        var possibleEvents: [Event] = []
        for event in Event.allEvents {
            if event.requirement() {
                if event.inevitable {
                    return event
                } else {
                    possibleEvents.append(event)
                }
            }
        }
        return possibleEvents[Int.random(in: 0..<possibleEvents.count)]
    }

    @IBAction func option1Press(_ sender: Any) {
        
        for mod in modifierList[0] {
            Civilization.shared.effects.append(mod)
        }
        
        leave()
    }
    @IBAction func option2Press(_ sender: Any) {
        
        for mod in modifierList[1] {
            Civilization.shared.effects.append(mod)
        }
        
        leave()
    }
    @IBAction func option3Press(_ sender: Any) {
        
        for mod in modifierList[2] {
            Civilization.shared.effects.append(mod)
        }
        
        leave()
    }
    
    func leave() {
        Civilization.shared.nextTurn()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var newViewController: UIViewController? = nil
        if Civilization.shared.activeAlerts.count == 0 {
            newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewControllerDashboard") as!ViewControllerDashboard
        } else {
            newViewController = storyBoard.instantiateViewController(withIdentifier: "AlertScreen") as!ViewControllerDashboard
        }
        self.present(newViewController!, animated: true, completion: nil)
    }
    
}
