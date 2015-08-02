//
//  FBLoginService.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/26/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit

class FBLoginService: NSObject, ISocialLoginService {
    
    var loginCallBack: ((connection: FBSDKGraphRequestConnection!,
        result: AnyObject!, error: NSError!) -> Void)? = nil
    var logoutCallBack: (() -> Void)? = nil
    var result: AnyObject? = nil
    
    override init() {
        super.init()
    }
    
    // MARK: - Shared Instance
    class func sharedInstance() -> FBLoginService {
        struct Singleton {
            static var sharedInstance = FBLoginService()
        }
        return Singleton.sharedInstance
    }
    
    // The controller subscribe to this function to get call back after login finish
    // If you dont want logoutCallBack of loginCallBack you can set it to be nil
    func subscribe(loginCallBack: ((connection: FBSDKGraphRequestConnection!,
        result: AnyObject!, error: NSError!) -> Void)?,
        logoutCallBack: (() -> Void)?) {
            self.loginCallBack = loginCallBack
            self.logoutCallBack = logoutCallBack
    }
    
    func unSubscribe() {
        loginCallBack = nil
        logoutCallBack = nil
    }
    
    // Use this function to logout at any time
    func logout() {
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            var loginManager = FBSDKLoginManager()
            loginManager.logOut()
            println("User logged out Facebook")
            if (logoutCallBack != nil) {
                logoutCallBack!()
            }
        }
    }
    
    // Use this function to login at any time
    func login() {
        var loginManager = FBSDKLoginManager()
        loginManager.logInWithPublishPermissions([], handler: {
            (result, error) -> Void in
            println("User logged in Facebook")
            self.returnUserData()
        })
    }
    
    // Call this function manually to retrieve user info
    // Will update this function in the feature to have a callback for needed data
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({
            (connection, result, error) in
            self.result = result
            if (self.loginCallBack != nil) {
                self.loginCallBack!(connection: connection, result: result, error: error)
            }
        })
    }
    
}
