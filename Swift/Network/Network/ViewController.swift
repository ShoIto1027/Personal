//
//  ViewController.swift
//  Network
//
//  Created by companion_ios on 2016/03/09.
//  Copyright © 2016年 companion_ios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func pushButton(sender: AnyObject) {
        
        if NetworkReachability.isOnline() {
            self.label.text = "Online"
        } else {
            self.label.text = "Offline"
        }
        
    }
}

