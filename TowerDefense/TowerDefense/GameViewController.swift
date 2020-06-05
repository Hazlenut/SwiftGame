//
//  GameViewController.swift
//  AGE OF WAR
//
//  Created by drew lee on 6/1/20.
//  Copyright © 2020 drew lee. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var population:Int = 0
    var turret:Int = 0
    var turretAmount:Int = 0
    var gold:Int = 0
    var age:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var j:Int = 20
        let buttons = ["R", "M", "I", "B", "1", "2", "Buy", "Sell", "Age", "Spec."]
        for i in buttons {
            let range = UIButton.init(type: .roundedRect)
            range.frame =  CGRect(x: j, y: 20, width: 50, height: 50)
            range.setTitle(i, for: .normal)
            range.layer.borderWidth = 3.0
            range.layer.borderColor = UIColor.white.cgColor
            range.backgroundColor = UIColor(white: 1, alpha: 0.3)
            range.titleLabel?.font =  UIFont(name: "GillSans-Italic", size: 20)
            range.tintColor = .black
            range.layer.cornerRadius = 15.0
            if i == "R" || i == "M" || i == "I" || i == "B" {
                range.addTarget(self, action: #selector(unitClicked), for: .touchUpInside)
            }
            else if i == "1" || i == "2"    {
                range.addTarget(self, action: #selector(buildTurret), for: .touchUpInside)
            }
            else if i == "Buy"{
                range.addTarget(self, action: #selector(buyTurret), for: .touchUpInside)
            }
            else if i == "Sell" {
                range.addTarget(self, action: #selector(sellTurret), for: .touchUpInside)
            }
            else if i == "Age" {
                range.addTarget(self, action: #selector(nextAge), for: .touchUpInside)
            }
            else if i == "Spec." {
                range.addTarget(self, action: #selector(sellTurret), for: .touchUpInside)
            }
            self.view.addSubview(range)
            j += 60
            if j == 260 || j == 540 {
                j += 40
            }
            
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func unitClicked(){
        if population == 10 {
            print("Population Maxed")
        }
        if population < 10 {
            population += 1
            print("Units:", population)
        }
    }
    
    @objc func buildTurret(){
        if turret == turretAmount {
            print("No available Spots")
        }
        if turret < turretAmount {
            turret += 1
            print("Turrets:", turret);
        }
    }
    
    @objc func buyTurret(){
        if turretAmount == 3 {
            print("Max Turrets")
        }
        if turretAmount < 3 {
            turretAmount += 1
            print("Turret Amount:", turretAmount);
        }
    }
    
    @objc func sellTurret(){
        if turret == 0 {
            print("No Turrets to Sell")
        }
        if turret > 0 {
        turret -= 1
        print("Turrets:", turret);
        }
    }
    
    @objc func nextAge(){
        if age == 6 {
            print("Max Age")
        }
        if age < 6 {
            age += 1
        }
        if age == 2 {
            print("Stone")
        }
        if age == 3 {
            print("Medieval")
        }
        if age == 4 {
            print("Modern")
        }
        if age == 5 {
            print("Future")
        }
        if age == 6 {
            print("Holy Land")
        }
    }
}

