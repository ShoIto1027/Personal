//
//  NetworkReachability.swift
//  Network
//
//  Created by Aryzae on 2016/03/09.
//  Copyright © 2016年 Aryzae. All rights reserved.
//

import SystemConfiguration

struct NetworkReachability {
    
    static func isOnline() -> Bool {
        var zeroAddress = sockaddr_in()
        bzero(&zeroAddress, sizeofValue(sockaddr_in))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let reachability = withUnsafePointer(&zeroAddress, {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }) else {
            return false
        }
        
        var flags = SCNetworkReachabilityFlags()
        
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.Reachable)
        let isNeedsConnection = flags.contains(.ConnectionRequired)
        
        return (isReachable && !isNeedsConnection)
    }
}