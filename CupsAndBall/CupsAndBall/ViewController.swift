//
//  ViewController.swift
//  CupsAndBall
//
//  Created by Javan.Chen on 2016/10/19.
//  Copyright © 2016年 Javan.Chen. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    var session: WCSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (WCSession.isSupported()) {
            session = WCSession.default()
            session.delegate = self;
            session.activate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func touchUpCup1Button(_ sender: AnyObject) {
        print("Cup 1")
        sentCupNum(cupNum: "1")
    }
    @IBAction func touchUpCup2Button(_ sender: AnyObject) {
        print("Cup 2")
        sentCupNum(cupNum: "2")
    }
    @IBAction func touchUpCup3Button(_ sender: AnyObject) {
        print("Cup 3")
        sentCupNum(cupNum: "3")
    }
    @IBAction func touchUpNoCupButton(_ sender: AnyObject) {
        print("No Cup")
        sentCupNum(cupNum: "0")
    }
    
    func sentCupNum(cupNum: String) {
        if WCSession.isSupported() {
            if WCSession.default().isReachable {
                print("isReachable, send value: \(cupNum)")
                let messageToSend = ["CupNum": cupNum]
                session.sendMessage(messageToSend, replyHandler: nil, errorHandler: {error in print("error: \(error)")})
            } else { print("no reachable") }
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

