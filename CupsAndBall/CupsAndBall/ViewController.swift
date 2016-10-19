//
//  ViewController.swift
//  CupsAndBall
//
//  Created by Javan.Chen on 2016/10/19.
//  Copyright © 2016年 Javan.Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func touchUpCup1Button(_ sender: AnyObject) {
        print("Cup 1")
    }
    @IBAction func touchUpCup2Button(_ sender: AnyObject) {
        print("Cup 2")
    }
    @IBAction func touchUpCup3Button(_ sender: AnyObject) {
        print("Cup 3")
    }
  
}

