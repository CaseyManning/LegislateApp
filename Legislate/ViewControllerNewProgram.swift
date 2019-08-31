//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerNewProgram: UIViewController {
    
    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        
        for i in 0..<Civilization.shared.possiblePograms.count {
            let x = testButton.frame.minX
            let y = Int(testButton.frame.minY) + (i*65)
            let lawButton = UIButton(frame: CGRect(x: x, y: CGFloat(y), width: testButton.frame.width, height:  testButton.frame.height))
            lawButton.setBackgroundImage(testButton.backgroundImage(for: .normal), for: .normal)
            lawButton.setTitleColor(UIColor.black, for: .normal)
            lawButton.titleLabel?.font = testButton.titleLabel?.font
            lawButton.setTitle(Civilization.shared.possiblePograms[i].getString(), for: .normal)
            lawButton.addTarget(self, action: #selector(self.pressedProgram), for: .touchUpInside)
            //            lawButton.addTarget(self, action: self.pressedLaw(_:), for: .touchUpInside)
            
            view.addSubview(lawButton)
        }
    }
    
    
    @objc public func pressedProgram(source: UIButton) {
        Civilization.shared.currentProgram = GovProgram.fromString(pname: source.titleLabel!.text!)
        Civilization.shared.programs.append(GovProgram.fromString(pname: source.titleLabel!.text!)!)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewControllerSpecificProgram") as!ViewControllerSpecificProgram
        self.present(newViewController, animated: false, completion: nil)
    }
}
