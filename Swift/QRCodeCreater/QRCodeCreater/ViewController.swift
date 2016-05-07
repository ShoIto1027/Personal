//
//  ViewController.swift
//  QRCodeCreater
//
//  Created by ShoIto on 2016/05/07.
//  Copyright © 2016年 ShoIto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, QRCodeCreater {
    // MARK: -
    @IBOutlet var textField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // set Delegate
        textField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - IBAction
    @IBAction func tapButton(sender: AnyObject) {
        imageView.image = createQRCode(textField.text, correctionLevel: "M", scale: 3.0)
    }

}

