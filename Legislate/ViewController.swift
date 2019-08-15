//
//  ViewController.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var easyButton: UIImageView!
    @IBOutlet weak var mediumButton: UIImageView!
    @IBOutlet weak var hardButton: UIImageView!
    @IBOutlet weak var nameTextBox: UITextField!
    
    var pressedImage: UIImage? = nil
    var unPressedImage: UIImage? = nil
    
    static var backgroundColor = UIColor(displayP3Red: 183/255, green: 199/255, blue: 210/255, alpha: 1)
    
    var difficulty = "Medium"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pressedImage = mediumButton.image
        unPressedImage = easyButton.image
        
        self.view.backgroundColor = ViewController.backgroundColor
        
        let defaults = UserDefaults.standard
        
        if defaults.string(forKey: "started") != nil && false {
            let loaded = defaults.string(forKey: "started")
            print("There is a key for started")
            if loaded == "true" {
                print("Game is already loaded")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewControllerDashboard") as!ViewControllerDashboard
                self.present(newViewController, animated: true, completion: nil)
            }
        } else {
            setUpDefaultCiv()
        }
    }
    
    func setUpDefaultCiv() {
        let defaults = UserDefaults.standard
        print("Setting up values for civ")
        defaults.set(5, forKey: "surplus")
        defaults.set(50, forKey: "population")
        defaults.set(50, forKey: "unrest")
        defaults.set(0, forKey: "poverty")
        let civ = Civilization.shared
        let startingCitizens = 50
        
        for _ in 0..<startingCitizens {
            civ.population.append(Citizen.generateCitizen())
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    @IBAction func easyPressed(_ sender: Any) {
        easyButton.image = pressedImage
        mediumButton.image = unPressedImage
        hardButton.image = unPressedImage
        difficulty = "Easy"
    }
    @IBAction func mediumPressed(_ sender: Any) {
        easyButton.image = unPressedImage
        mediumButton.image = pressedImage
        hardButton.image = unPressedImage
        difficulty = "Medium"
    }
    @IBAction func hardPressed(_ sender: Any) {
        easyButton.image = unPressedImage
        mediumButton.image = unPressedImage
        hardButton.image = pressedImage
        difficulty = "Hard"
    }
    @IBAction func beginPressed(_ sender: Any) {
        print("Yeehaw")
        
        let defaults = UserDefaults.standard
        defaults.set(nameTextBox.text, forKey: "name")
        Civilization.shared.name = nameTextBox.text ?? "Unnamed"
        defaults.set(difficulty, forKey: "difficulty")
        
        Alert.addAlerts()
        
    }
}
