//
//  QRCodeReader.swift
//  QRCodeReader
//
//  Created by ShoIto on 2016/04/29.
//  Copyright © 2016年 ShoIto. All rights reserved.
//

import UIKit
import AVFoundation

protocol CodeProtocol {
    func foundCode(code: String)
}

class QRCodeReader: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    // MARK: -
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var delegate: AnyObject?
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        captureSession = AVCaptureSession()
        
        let videoCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        let videoInput: AVCaptureDeviceInput
        let metadataOutput = AVCaptureMetadataOutput()
        
        // tryでやらないとAVCaptureDeveceInputにErrorが出る
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            // error handling
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            launchFailed();
            return;
        }
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            // 認識させる物
            metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        } else {
            launchFailed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession);
        previewLayer.frame = view.layer.bounds;
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        view.layer.addSublayer(previewLayer);
        
        // 開始
        captureSession.startRunning();
    }
    
    // 起動失敗時(主にSimulater時)
    func launchFailed() {
        let alert = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code. Please use a device with a camera.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        captureSession = nil
    }
    
    // MARK: - AVCaptureMetadataOutputObjectsDelegate
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        // 停止
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            let readableObject = metadataObject as! AVMetadataMachineReadableCodeObject
            
            // 読み取ったことを振動で知らせる
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            guard let delegateVC: ViewController = (delegate as! ViewController) else {
                return
            }
            delegateVC.foundCode(readableObject.stringValue);
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}