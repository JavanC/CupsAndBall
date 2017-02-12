//
//  ViewController.swift
//  CupsAndBall
//
//  Created by Javan.Chen on 2016/10/19.
//  Copyright © 2016年 Javan.Chen. All rights reserved.
//

import UIKit
import WatchConnectivity

enum Status {
    case exchange
    case select
}

class ViewController: UIViewController, WCSessionDelegate {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cup1Button: UIButton!
    @IBOutlet weak var cup2Button: UIButton!
    @IBOutlet weak var cup3Button: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    
    var status: Status = .exchange
    var session: WCSession!
    var cups: [UIButton] = []
    var lastCupNumber: Int = 0
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            session = WCSession.default()
            session.delegate = self;
            session.activate()
        }
        
        statusLabel.text = String(describing: status)
        cups = [cup1Button, cup2Button, cup3Button]
        
        for (index, cup) in cups.enumerated() {
            let x = self.view.frame.width * CGFloat(index + 1) / 4
            let y = self.view.frame.height / 2
            cup.center = CGPoint(x: x, y: y)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Click Button Event
    
    func exchangeCup(Cup1: UIButton, Cup2: UIButton, duration: TimeInterval, delay: TimeInterval, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            let tempPoint = Cup1.center
            Cup1.center = Cup2.center
            Cup2.center = tempPoint
        }, completion: {_ in completion?() })
    }
    
    @IBAction func didClickCupButton(_ currentCup: UIButton) {
        
        if status == .exchange {
            if cups.filter({ $0.isSelected }).count > 0 {
                let lastCup = cups[lastCupNumber]
                if lastCup == currentCup {
                    currentCup.isSelected = false
                } else {
                    exchangeCup(Cup1: currentCup, Cup2: lastCup, duration: 0.5, delay: 0, completion: {
                        lastCup.isSelected = false
                    })
                }
            } else {
                lastCupNumber = currentCup.tag
                currentCup.isSelected = true
            }
        } else if status == .select {
            // show the Answer
            let message = currentCup == cup2Button ? "Correct!" : "Sorry..."
            let alert = UIAlertController(title: "Answer", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { _ in
                // change status
                self.status = .exchange
                self.okButton.isHidden = false
                self.randomButton.isHidden = false
                self.statusLabel.text = "Please exchange the cup."
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionOKButton(_ sender: UIButton) {
        status = .select
        okButton.isHidden = true
        randomButton.isHidden = true
        statusLabel.text = "Please select the cup with the ball."
        
        var locations: [CGPoint] = []
        for cup in cups {
            locations.append(cup.center)
            cup.isSelected = false
        }
        
        locations.sort{ $0.x < $1.x }
        for (index, location) in locations.enumerated() {
            if location == cup2Button.center {
                print("Ball in \(index + 1)")
                sentCupNum(cupNum: index)
            }
        }
    }
    
    @IBAction func actionRandomButton(_ sender: Any) {
        let randomNumber = 4 + arc4random_uniform(6)
        for count in 0..<randomNumber {
            while true {
                let cup1Num = Int(arc4random_uniform(3))
                let cup2Num = Int(arc4random_uniform(3))
                if cup1Num != cup2Num {
                    exchangeCup(Cup1: cups[cup1Num], Cup2: cups[cup2Num], duration: 0.3, delay: Double(count) * 0.3, completion: nil)
                    break
                }
            }
        }
    }
    
    // MARK: - WCSession Delegate
 
    func sentCupNum(cupNum: Int) {
        if WCSession.isSupported() {
            let dictData = ["CupNum": cupNum]
            session.transferUserInfo(dictData)
        } else { print("no supported WCSession") }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("become inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("deactivate")
    }
}

