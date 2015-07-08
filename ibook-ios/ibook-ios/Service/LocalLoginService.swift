//
//  LocalLoginService.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/7/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import Foundation

public class LocalLoginImp: NSObject, ILogin {
    
    // fake data
    var data = [
        "nongdenchet" : "android",
        "hqt" : "ibook",
        "ledaiphat" : "apidez"
    ]
    
    public func login(username: String!, password: String!, done: (success: Bool) -> Void) {
        let backgroundQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
        
        // Run this code in background
        dispatch_async(backgroundQueue, {
            NSThread.sleepForTimeInterval(3) // fake the login api
            let result = (self.data[username] != nil && self.data[username] == password)
            
            // run this code on main thread to send the result back
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                done(success: result)
            })
        })
    }

}