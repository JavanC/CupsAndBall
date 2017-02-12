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
    var ballInCupNum: Int = 0
    
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
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.3) {
            self.vibrateWatch(vibrateNum: self.ballInCupNum)
        }
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
    }
    
    // MARK: - Background Transfers
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        if let value = userInfo["CupNum"] as? Int {
            print("Receive message: \(value)")
            
            ballInCupNum = value
            vibrateWatch(vibrateNum: ballInCupNum)
            DispatchQueue.main.async {
                self.cupNumLabel.setText(String(value + 1))
            }
        }
    }

    func vibrateWatch(vibrateNum: Int) {
        switch vibrateNum {
        case 0:
            WKInterfaceDevice.current().play(WKHapticType.retry)
        case 1:
            WKInterfaceDevice.current().play(WKHapticType.retry)
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.8) {
                WKInterfaceDevice.current().play(WKHapticType.retry)
            }
        case 2:
            WKInterfaceDevice.current().play(WKHapticType.retry)
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.8) {
                WKInterfaceDevice.current().play(WKHapticType.retry)
            }
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.6) {
                WKInterfaceDevice.current().play(WKHapticType.retry)
            }
        default:
            break
        }
    }
}
