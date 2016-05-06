//
//  ViewController.swift
//  QRCodeReader
//
//  Created by ShoIto on 2016/04/29.
//  Copyright © 2016年 ShoIto. All rights reserved.
//

import UIKit



class ViewController: UIViewController, CodeProtocol {

    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        label.adjustsFontSizeToFitWidth = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapButton(sender: AnyObject) {
        let qrvc = QRCodeReader()
        qrvc.delegate = self
        presentViewController(qrvc, animated: true, completion: nil)
    }

    func foundCode(code: String) {
        print(code)
        label.text = code
        UIPasteboard.generalPasteboard().string = code;
    }
}

