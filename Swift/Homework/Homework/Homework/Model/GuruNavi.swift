//
//  GuruNavi.swift
//  Homework
//
//  Created by Aryzae on 2016/08/20.
//  Copyright © 2016年 ShoIto. All rights reserved.
//

import Foundation

class GuruNavi: NSObject {
    
    private let apiUrl = "http://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=f92d6f4f90e7f90ebeb4977a330723c4&format=json"
    private let configuration: NSURLSessionConfiguration = .defaultSessionConfiguration()
    
    func requestJson() {
        guard let url = NSURL(string: apiUrl) else {
            return
        }
        let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: .currentQueue())
        let dataTask = session.dataTaskWithURL(url)
        
        dataTask.resume()
    }
    
    func parseJsonToDictionary() {
        
    }
}

// MARK: - NSURLSessionTaskDelegate
extension GuruNavi: NSURLSessionTaskDelegate {
    // session開始時
    func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
        if error != nil {
            // errorあり
            print(error)
            
        }
    }

//    func URLSession(session: NSURLSession, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void)
    
//    func URLSessionDidFinishEventsForBackgroundURLSession(session: NSURLSession)

//    func URLSession(session: NSURLSession, task: NSURLSessionTask, willPerformHTTPRedirection response: NSHTTPURLResponse, newRequest request: NSURLRequest, completionHandler: (NSURLRequest?) -> Void)

//    func URLSession(session: NSURLSession, task: NSURLSessionTask, didReceiveChallenge challenge: NSURLAuthenticationChallenge, completionHandler: (NSURLSessionAuthChallengeDisposition, NSURLCredential?) -> Void)

//    func URLSession(session: NSURLSession, task: NSURLSessionTask, needNewBodyStream completionHandler: (NSInputStream?) -> Void)

//    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64)
    
    // session終了時
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            // errorあり
            print(error)
            
        } else {
            // errorなし(正常終了)
            
        }
    }
}