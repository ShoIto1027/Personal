//
//  QRCodeCreater.swift
//  QRCodeCreater
//
//  Created by ShoIto on 2016/05/07.
//  Copyright © 2016年 ShoIto. All rights reserved.
//

import UIKit
import CoreImage

let QRCodeGenerator = "CIQRCodeGenerator"
let InputMessage = "inputMessage"
let InputCorrectionLevel = "inputCorrectionLevel"
let CorrectionLevelDefault = "M"
let QRCodeScaleDefault: CGFloat = 1.0

protocol QRCodeCreater {
    func createQRCode(text: String?, correctionLevel: String?, scale: CGFloat?) -> UIImage?
}

extension QRCodeCreater {
    func createQRCode(text: String?, correctionLevel: String?, scale: CGFloat?) -> UIImage? {
        // Default値設定(出来れば!を使わないように書くべきか)
        text == nil ? "" : text
        correctionLevel == nil ? CorrectionLevelDefault : correctionLevel
        scale == nil ? QRCodeScaleDefault : scale
        
        // textをUTF8にEncode
        guard let encodeText = text!.dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        let qrCodeParameters: Dictionary<String, AnyObject> = [InputMessage: encodeText, InputCorrectionLevel: correctionLevel!]
        // parameter設定してQR作成
        guard let qrCode = CIFilter(name: QRCodeGenerator, withInputParameters: qrCodeParameters) else {
            return nil
        }
        
        // resize
        let sizeTransform = CGAffineTransformMakeScale(scale!, scale!)
        // create
        guard let outputImage = qrCode.outputImage else {
            return nil
        }
        let image = outputImage.imageByApplyingTransform(sizeTransform)
        
        return UIImage(CIImage: image, scale: 1, orientation: .Up)
    }
}