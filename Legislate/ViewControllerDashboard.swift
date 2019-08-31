//
//  ViewControllerLaws.swift
//  ReignsGame
//
//  Created by Casey Manning on 8/11/19.
//  Copyright © 2019 Casey Manning. All rights reserved.
//

import Foundation
import UIKit


class ViewControllerDashboard: UIViewController {

    @IBOutlet weak var povertyButton: UIButton!
    @IBOutlet weak var unrestButton: UIButton!
    @IBOutlet weak var surplusButton: UIButton!
    @IBOutlet weak var populationButton: UIButton!
    
    @IBOutlet weak var surplusNum: UILabel!
    @IBOutlet weak var populationNum: UILabel!
    @IBOutlet weak var unrestNum: UILabel!
    @IBOutlet weak var povertyNum: UILabel!
    @IBOutlet weak var turnNum: UILabel!
    
    @IBOutlet weak var civilizationMarkerLabel: UILabel!
    
    var mapScrollX = CGFloat(0)
    var mapScrollY = CGFloat(0)
    
    @IBOutlet weak var civilizationMarkerDot: UIImageView!
    
    @IBOutlet weak var mapBackground: UIImageView!

    @IBOutlet weak var mapGrid: UIImageView!
    
    var startLocation: CGPoint?
    
    @IBOutlet weak var militaryButton: UIButton!
    override func viewDidLoad() {
        print("Loading Dashboard View")
        super.viewDidLoad()
        self.view.backgroundColor = ViewController.backgroundColor
        
        let defaults = UserDefaults.standard
        defaults.set("true", forKey: "started")
        
        
        Civilization.shared.update()
        Civilization.shared.unrest -= 1
        Civilization.shared.unrest += 1
        Civilization.shared.calculateUnrest()
        surplusNum.text = String(Int(Civilization.shared.wealth))
        populationNum.text = String(Int(Civilization.shared.population.count))
        unrestNum.text = String(Int(Civilization.shared.unrest))
        povertyNum.text = String(Int(Civilization.shared.poverty))
        
        civilizationMarkerLabel.text = Civilization.shared.name
        
        turnNum.text = "Turn: " + String(Civilization.shared.turn)
        
        addPanGesture(view: mapBackground)
    }
    
    @IBAction func endTurnPressed(_ sender: Any) {
        
    }
    
    func configureMask(button:UIImageView, with image:UIImage!){
        let masklayer = CALayer()
        masklayer.frame.origin = CGPoint(x: mapBackground.frame.minX - 173 - self.mapScrollX, y: mapBackground.frame.minX - 173 - self.mapScrollY)
        masklayer.frame.size = CGSize(width: 240, height: 240)
        masklayer.contents = image.cgImage
        button.layer.mask = masklayer
    }
    
    func renderMap() {
        civilizationMarkerDot.center.x = self.view.center.x + self.mapScrollX
        civilizationMarkerDot.center.y = self.view.center.y + self.mapScrollY
        view.bringSubviewToFront(civilizationMarkerDot)
        
        civilizationMarkerLabel.center.x = civilizationMarkerDot.center.x
        civilizationMarkerLabel.center.y = civilizationMarkerDot.center.y - 30
//        view.bringSubviewToFront(civilizationMarkerLabel)
        mapGrid.center.x = self.view.center.x + self.mapScrollX
        mapGrid.center.y = self.view.center.y + self.mapScrollY
        
//        let mutablePath = CGMutablePath()
//
//        mutablePath.addRect(mapBackground.bounds)
//        mutablePath.addRect(view.bounds)
//        // Create a shape layer and cut out the intersection
//        let mask = CALayer()
//        mask.frame.origin = CGPoint(x: mapScrollX, y: mapScrollX)
//        mask.frame.size = mapBackground.frame.size
//        mask.contents = mapBackground.image?.cgImage
//        mask.path = mutablePath
//        mask.fillRule = CAShapeLayerFillRule.evenOdd
        
        configureMask(button: civilizationMarkerDot, with:  mapBackground.image)
        
        
//        civilizationMarkerDot.layer.mask = mask
//        mapGrid.layer.mask = mask
    }
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewControllerDashboard.handlePan(sender:)))
        
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
//        let translation = sender.translation(in: sender.view)
//        sender.location(in: view).x
       
        switch sender.state {
        case .began:
            print("Starting pan")
            startLocation = sender.location(in: view)
        case .changed:
            mapScrollX -= (startLocation!.x - sender.location(in: view).x)/50
            mapScrollY -= (startLocation!.y - sender.location(in: view).y)/50
            renderMap()
        default:
            break
        }
        
    }
}
