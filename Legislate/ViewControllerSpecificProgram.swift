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
    @IBOutlet weak var groupText: UITextField!
    @IBOutlet weak var suggestionBox: UIButton!
    
    var currentRecip = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        titleText.text = Civilization.shared.currentProgram?.name
        descriptionLabel.text = Civilization.shared.currentProgram?.description
        
        suggestionBox.setTitle(Civilization.shared.currentProgram?.affectedGroups[0], for: .normal)
    }
    @IBAction func groupEdited(_ sender: Any) {
        if Civilization.shared.socialGroups.contains(groupText.text!) {
            suggestionBox.isHidden = true
        } else {
            suggestionBox.isHidden = false
        }
        currentRecip = groupText.text!
        let gs = Civilization.shared.socialGroups.sorted(by: checkRecip)
        suggestionBox.setTitle(gs[0], for: .normal)
    }
    
    func checkRecip(a: String, b:String) -> Bool {
        let commonA = a.commonPrefix(with: currentRecip)
        let commonB = b.commonPrefix(with: currentRecip)
        
        return commonA.count > commonB.count
    }
    
    @IBAction func removePressed(_ sender: Any) {
        Civilization.shared.programs.remove(at: Civilization.shared.programs.firstIndex(of: Civilization.shared.currentProgram!)!)
    }
    @IBAction func suggestionPressed(_ sender: Any) {
        groupText.text = suggestionBox.titleLabel?.text
        suggestionBox.isHidden = true
        Civilization.shared.currentProgram?.affectedGroups = [groupText.text] as! [String]
        if case let count = Civilization.shared.currentProgram?.effects.count {
            for i in 0..<count! {
                Civilization.shared.currentProgram?.effects[i].affectedGroups = Civilization.shared.currentProgram!.affectedGroups
            }
        }
    }
}
