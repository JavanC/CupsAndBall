//
//  InterfaceController.swift
//  CupsAndBall WatchKit Extension
//
//  Created by Javan.Chen on 2016/10/19.
//  Copyright © 2016年 Javan.Chen. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var cupNumLabel: WKInterfaceLabel!
    var session : WCSession!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if (WCSession.isSupported()) {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func cupNumChange(cupNum: String) {
        switch cupNum {
        case "0":
            self.cupNumLabel.setText("0")
        case "1":
            self.cupNumLabel.setText("1")
            vibrateWatch(vibrateNum: 1)
        case "2":
            self.cupNumLabel.setText("2")
            vibrateWatch(vibrateNum: 2)
        case "3":
            self.cupNumLabel.setText("3")
            vibrateWatch(vibrateNum: 3)
        default:
            break
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let value = message["CupNum"] as? String {
            print("Receive message: \(value)")
            DispatchQueue.main.async {
                self.cupNumChange(cupNum: value)
            }
        }
    }
    
    func vibrateWatch(vibrateNum: Int) {
        switch vibrateNum {
        case 1:
            WKInterfaceDevice.current().play(WKHapticType.retry)
        case 2:
            WKInterfaceDevice.current().play(WKHapticType.retry)
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                WKInterfaceDevice.current().play(WKHapticType.retry)
            }
        case 3:
            WKInterfaceDevice.current().play(WKHapticType.retry)
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                WKInterfaceDevice.current().play(WKHapticType.retry)
            }
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                WKInterfaceDevice.current().play(WKHapticType.retry)
            }
        default:
            break
        }
    }
}
