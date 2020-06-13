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

class GameViewController: UIViewController, UIScrollViewDelegate {
    var population:Int = 0
    var turret:Int = 0
    var turretAmount:Int = 0
    var gold:Int = 100000
    var age:Int = 0
    var unit:String = "hi"
    var scrollView: UIScrollView!
    let textData: String = "abcdefghijklmnopqrstuvwxyz now i know my abcs next time wont you sing with me aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz nnooww ii kknnooww mmyy aabbccss nneexxtt ttiimmee wwoonntt yyoouu ssiinngg wwiitthh mmee"

    /*
    let labelOne: UILabel = {
        let label = UILabel()
        label.text = "Scroll Top"
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let labelTwo: UILabel = {
        let label = UILabel()
        label.text = "Scroll Bottom"
        label.backgroundColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cyan
        return v
    }()
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        self.view.addSubview(scrollView)
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0).isActive = true

        // add labelOne to the scroll view
        scrollView.addSubview(labelOne)

        // constrain labelOne to left & top with 16-pts padding
        // this also defines the left & top of the scroll content
        labelOne.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
        labelOne.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0).isActive = true

        // add labelTwo to the scroll view
        scrollView.addSubview(labelTwo)

        // constrain labelTwo at 400-pts from the left
        labelTwo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 400.0).isActive = true

        // constrain labelTwo at 1000-pts from the top
        labelTwo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 1000).isActive = true

        // constrain labelTwo to right & bottom with 16-pts padding
        labelTwo.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16.0).isActive = true
        labelTwo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true

        
        */
        
        
        var j:Int = 20
        let buttons = ["R", "M", "I", "B", "1", "2", "Buy", "Sell", "Age", "Spec."]
        for i in buttons {
            let range = UIButton.init(type: .roundedRect)
            range.frame =  CGRect(x: j, y: 20, width: 50, height: 50)
            range.setTitle(i, for: .normal)
            range.layer.borderWidth = 3.0
            range.layer.borderColor = UIColor.black.cgColor
            range.backgroundColor = UIColor(white: 1, alpha: 0.3)
            range.titleLabel?.font =  UIFont(name: "GillSans-Italic", size: 20)
            range.tintColor = .black
            range.layer.cornerRadius = 15.0
            if i == "R" || i == "M" || i == "I" || i == "B" {
                range.addTarget(self, action: #selector(unitClicked1), for: .touchUpInside)
            }
            else if i == "1" || i == "2" {
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
            self.scrollView = UIScrollView()
            self.scrollView.delegate = self
            let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 1000, height: 200))
            textLabel.text = textData
            self.scrollView.contentSize = CGSize(width: textLabel.frame.width, height: textLabel.frame.height)

                       scrollView.addSubview(textLabel)
            view.addSubview(scrollView)
            view.ignoresSiblingOrder = true
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @objc func unitClicked1(_ sender: UIButton){
        let unitType = sender.title(for: .normal)!
        
        if population == 10 {
            print("Population Maxed")
        }
        if population < 10 {
            population += 1
            print("Units:", population)
            if String(unitType) == "R" {gold -= 25 + age * 10}
            else if String(unitType) == "M" {gold -= 35 + age * 12}
            else if String(unitType) == "I" {gold -= 45 + age * 12}
            else if String(unitType) == "B" {gold -= 55 + age * 15}
            print(gold)
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
            print("Turret Amount:", turretAmount)
            gold -= age * 50
            print(gold)
        }
    }
    
    @objc func sellTurret(){
        if turret == 0 {
            print("No Turrets to Sell")
        }
        if turret > 0 {
            turret -= 1
            print("Turrets:", turret)
            gold += age * 25
        }
    }
    
    @objc func nextAge(){
        let ages = ["random","Stone","Med","Modern","Future","Holy land"]
        if age < 5 {age += 1}
        print(ages[age])
        gold -= age * 500
    }
    
    @objc func special(){
        //Int.random(in: 1..<100)
        
    }
    
    func main(){
        print(gold)
    }
}

