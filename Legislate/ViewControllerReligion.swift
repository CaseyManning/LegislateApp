//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerReligion: UIViewController {
    
    @IBOutlet weak var civType1Button: UIButton!
    @IBOutlet weak var civType2Button: UIButton!
    @IBOutlet weak var civType3Button: UIButton!
    
    @IBOutlet weak var popupWindow: UIImageView!
    @IBOutlet weak var closePopupButton: UIButton!
    var selectedImage: UIImage?
    var unSelectedImage: UIImage?
    @IBOutlet weak var popupTitle: UILabel!
    @IBOutlet weak var popupDescription: UILabel!
    
    @IBOutlet weak var attributeLabel1: UILabel!
    @IBOutlet weak var attributeLabel2: UILabel!
    let religionTypes = ["Atheist", "Seperate Church", "Integrated Theocracy"]
    
    let civilizationDescriptions = [
        "Atheist": "You do not participate in religon at all. Spiritual practice is common (unless you do something about it) but you do not intefere with matters of faith.",
        "Seperate Church": "Your society has a structured religious organization, but one that is separate from the state, with separate respnsibilities.",
        "Integrated Theocracy": "Religon is integrated into the state such that the leader of your society also leads in all matters of religion, and the state tightly controls relious practice and customs.",
    ]
    
    let civilizationAtributes = [
        "Atheist": ["+25% population growth", "-50% Unrest from poverty"],
        "Seperate Church": ["-25% Administrative Power", "-25% Unrest"],
        "Integrated Theocracy": ["-10% population growth", "-50% Unrest from taxes"]
    ]
    let civilizationAtributeReds = [
        "Atheist": [[0, 0], [0,0]],
        "Seperate Church": [[0, 0], [0,0]],
        "Integrated Theocracy": [[0, 0], [0,0]]
    ]
    let civilizationAtributeGreens = [
        "Atheist": [[0,0], [0,0]],
        "Seperate Church": [[0, 0], [0,0]],
        "Integrated Theocracy": [[0, 0], [0,0]]
    ]
    
    var civType = "Tribal Federation"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        self.popupWindow.alpha = 0
        selectedImage = civType2Button.backgroundImage(for: .normal)
        unSelectedImage = civType1Button.backgroundImage(for: .normal)
        
        popupWindow.alpha = 0
        closePopupButton.alpha = 0
        popupTitle.alpha = 0
        popupDescription.alpha = 0
        attributeLabel1.alpha = 0
        attributeLabel2.alpha = 0
        
        civType1Button.setTitle(religionTypes[0], for: .normal)
        civType2Button.setTitle(religionTypes[1], for: .normal)
        civType3Button.setTitle(religionTypes[2], for: .normal)
    }
    @IBAction func civ1Pressed(_ sender: Any) {
        civType1Button.setBackgroundImage(selectedImage, for: .normal)
        civType2Button.setBackgroundImage(unSelectedImage, for: .normal)
        civType3Button.setBackgroundImage(unSelectedImage, for: .normal)
        
        showPopup(type: religionTypes[0])
        Civilization.shared.civilizationType = religionTypes[0]
    }
    @IBAction func civ2Pressed(_ sender: Any) {
        civType2Button.setBackgroundImage(selectedImage, for: .normal)
        civType1Button.setBackgroundImage(unSelectedImage, for: .normal)
        civType3Button.setBackgroundImage(unSelectedImage, for: .normal)
        popupWindow.isHidden = false;
        
        showPopup(type: religionTypes[1])
        Civilization.shared.civilizationType = religionTypes[1]
    }
    @IBAction func civ3Pressed(_ sender: Any) {
        civType3Button.setBackgroundImage(selectedImage, for: .normal)
        civType2Button.setBackgroundImage(unSelectedImage, for: .normal)
        civType1Button.setBackgroundImage(unSelectedImage, for: .normal)
        popupWindow.isHidden = false;
        
        showPopup(type: religionTypes[2])
        Civilization.shared.civilizationType = religionTypes[2]
    }
    
    func showPopup(type: String) {
        popupTitle.text = type
        popupDescription.text = civilizationDescriptions[type]
        
        let green = UIColor(displayP3Red: 0.1, green: 0.8, blue: 0.1, alpha: 1)
        
        let myMutableString = NSMutableAttributedString(string: (civilizationAtributes[type]?[0])!, attributes: [NSAttributedString.Key.font:UIFont(name: "Futura", size: 17.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:civilizationAtributeReds[type]![0][0],length:civilizationAtributeReds[type]![0][1]))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: green, range: NSRange(location:civilizationAtributeGreens[type]![0][0],length:civilizationAtributeGreens[type]![0][1]))

        attributeLabel1.attributedText = myMutableString
        
        let myMutableString2 = NSMutableAttributedString(string: (civilizationAtributes[type]?[1])!, attributes: [NSAttributedString.Key.font:UIFont(name: "Futura", size: 17.0)!])
        print(civilizationAtributeReds[type]![1][0])
        print(civilizationAtributeReds[type]![1][1])
        myMutableString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:civilizationAtributeReds[type]![1][0],length:civilizationAtributeReds[type]![1][1]))
        myMutableString2.addAttribute(NSAttributedString.Key.foregroundColor, value: green, range: NSRange(location:civilizationAtributeGreens[type]![1][0],length:civilizationAtributeGreens[type]![1][1]))
        attributeLabel2.attributedText = myMutableString2
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.popupWindow.alpha = 1
                self.closePopupButton.alpha = 1
                self.popupTitle.alpha = 1
                self.popupDescription.alpha = 1
                self.attributeLabel1.alpha = 1
                self.attributeLabel2.alpha = 1
            }, completion: nil)
        })
        popupWindow.isHidden = false;
    }
    
    @IBAction func closePopup(_ sender: Any) {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.popupWindow.alpha = 0
            self.closePopupButton.alpha = 0
            self.popupTitle.alpha = 0
            self.popupDescription.alpha = 0
            self.attributeLabel1.alpha = 0
            self.attributeLabel2.alpha = 0
        }, completion: nil)
        
    }
    @IBAction func nextPressed(_ sender: Any) {
        print("Saving Civilization Type")
    }
    
}
