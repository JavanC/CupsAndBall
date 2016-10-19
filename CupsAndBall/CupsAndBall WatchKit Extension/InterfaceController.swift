//
//  InterfaceController.swift
//  CupsAndBall WatchKit Extension
//
//  Created by Javan.Chen on 2016/10/19.
//  Copyright © 2016年 Javan.Chen. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func touchUpShakeButton() {
        print("Shake")
        WKInterfaceDevice.current().play(.click)
    }
    
}
