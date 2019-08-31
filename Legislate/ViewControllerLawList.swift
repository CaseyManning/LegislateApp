//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerLawList: UIViewController {
    
    var lawsFromString: Dictionary<String, Law> = [:]
    
    @IBOutlet weak var testButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
//        updateList()
        testButton.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            print(Civilization.shared.laws)
            print("Reupdating")
            self.updateList()
        })
    }
    
    func updateList() {
        let laws = Civilization.shared.laws
//        for view in view.subviews{
//            if let v = view as? UIButton  {
//                if (view as? UIButton)?.backgroundImage(for: .normal) != nil {
//                    print((view as? UIButton)?.backgroundImage(for: .normal))
//                    if (view as? UIButton)?.backgroundImage(for: .normal) == testButton.backgroundImage(for: .normal) {
//                        view.removeFromSuperview()
//                    }
//                }
//            }
//        }
        for i in 0..<laws.count {
            let x = testButton.frame.minX
            let y = Int(testButton.frame.minY) + (i*65)
            let lawButton = UIButton(frame: CGRect(x: x, y: CGFloat(y), width: testButton.frame.width, height:  testButton.frame.height))
            lawButton.setBackgroundImage(testButton.backgroundImage(for: .normal), for: .normal)
            lawButton.setTitleColor(UIColor.black, for: .normal)
            lawButton.titleLabel?.font = testButton.titleLabel?.font
            lawButton.setTitle(laws[i].generateLawString(), for: .normal)
            lawButton.addTarget(self, action: #selector(self.pressedLaw), for: .touchUpInside)
            lawsFromString.updateValue(laws[i], forKey: laws[i].generateLawString())
            //            lawButton.addTarget(self, action: self.pressedLaw(_:), for: .touchUpInside)
            
            view.addSubview(lawButton)
        }
    }
    
    @objc public func pressedLaw(source: UIButton) {
        Civilization.shared.currentLaw = lawsFromString[source.titleLabel!.text!]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewControllerSpecificLaw") as!ViewControllerSpecificLaw
        self.present(newViewController, animated: false, completion: nil)
    }
}
