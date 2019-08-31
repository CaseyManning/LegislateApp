//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerEnactLaw: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lawTextBox: UITextField!
    @IBOutlet weak var lawTypeButton: UIButton!
    @IBOutlet weak var legalizeButton: UIButton!
    
    @IBOutlet weak var suggestion1: UIButton!
    @IBOutlet weak var suggestion2: UIButton!
    @IBOutlet weak var suggestion3: UIButton!
    
    @IBOutlet weak var recipientBox: UITextField!
    @IBOutlet weak var recipientSuggestion: UIButton!
    
    var laws = Law.laws
    
    var current = ""
    var currentRecip = ""
    
    var legalizeImage: UIImage? = nil
    var banImage: UIImage? = nil
    
    var groups = Civilization.shared.socialGroups
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        banImage = lawTypeButton.backgroundImage(for: .normal)
        legalizeImage = legalizeButton.backgroundImage(for: .normal)
    }
    @IBAction func typing(_ sender: Any) {
        
        current = lawTextBox.text!
        
        laws = laws.sorted(by: check)

        suggestion1.setTitle(laws[0], for: .normal)
        suggestion2.setTitle(laws[1], for: .normal)
        suggestion3.setTitle(laws[2], for: .normal)
        
        if laws.contains(lawTextBox.text!) {
            suggestion1.isHidden = true
            suggestion2.isHidden = true
            suggestion3.isHidden = true
        } else {
            suggestion1.isHidden = false
            suggestion2.isHidden = false
            suggestion3.isHidden = false
        }
        lawTextBox.autocapitalizationType = .words
        recipientBox.autocapitalizationType = .words
        
        recipientBox.delegate = self
        lawTextBox.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func check(a: String, b:String) -> Bool {
        let commonA = a.commonPrefix(with: current)
        let commonB = b.commonPrefix(with: current)
        
        return commonA.count > commonB.count
    }
    @IBAction func suggestion1Pressed(_ sender: Any) {
        lawTextBox.text = suggestion1.titleLabel?.text
        suggestion1.isHidden = true
        suggestion2.isHidden = true
        suggestion3.isHidden = true
    }
    @IBAction func suggestion2Pressed(_ sender: Any) {
        lawTextBox.text = suggestion2.titleLabel?.text
        suggestion1.isHidden = true
        suggestion2.isHidden = true
        suggestion3.isHidden = true
    }
    @IBAction func suggestion3Pressed(_ sender: Any) {
        lawTextBox.text = suggestion3.titleLabel?.text
        suggestion1.isHidden = true
        suggestion2.isHidden = true
        suggestion3.isHidden = true
    }
    @IBAction func lawTypeChange(_ sender: Any) {
        if lawTypeButton.titleLabel?.text == "Ban" {
            lawTypeButton.setTitle("Legalize", for: .normal)
            lawTypeButton.setBackgroundImage(legalizeImage, for: .normal)
        } else {
            lawTypeButton.setTitle("Ban", for: .normal)
            lawTypeButton.setBackgroundImage(banImage, for: .normal)
        }
    }
    @IBAction func lawRecipientChange(_ sender: Any) {
        currentRecip = recipientBox.text!
        
        groups = Civilization.shared.socialGroups.sorted(by: checkRecip)
        
        recipientSuggestion.setTitle(groups[0], for: .normal)
        
        if groups.contains(recipientBox.text!) {
            recipientSuggestion.isHidden = true
            print("hiding suggestion box")
        } else {
            recipientSuggestion.isHidden = false
            print("showing suggestion box")
        }
    }
    
    func checkRecip(a: String, b:String) -> Bool {
        let commonA = a.commonPrefix(with: currentRecip)
        let commonB = b.commonPrefix(with: currentRecip)
        
        return commonA.count > commonB.count
    }
    @IBAction func recipientSuggestionPressed(_ sender: Any) {
        recipientBox.text = groups[0]
        recipientSuggestion.isHidden = true
    }
    @IBAction func enactLaw(_ sender: Any) {
        
        if laws.contains(lawTextBox.text!) {
            let type = lawTypeButton.titleLabel?.text
            Civilization.shared.laws.append(Law(type: type!, action: lawTextBox.text!, forGroup: recipientBox.text!))
        }
        
    }
}
