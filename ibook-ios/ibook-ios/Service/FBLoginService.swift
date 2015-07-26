//
//  FBLoginService.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/26/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit


class FBLoginService: NSObject, FBSDKLoginButtonDelegate {
    
    var loginCallBack: ((result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void)? = nil
    var logoutCallBack: (() -> Void)? = nil
    
    override init() {
        super.init()
    }
    
    func subscribe(loginCallBack: ((result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void)?,
        logoutCallBack: (() -> Void)?) {
            self.loginCallBack = loginCallBack
            self.logoutCallBack = logoutCallBack
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!,
        error: NSError!) {
            println("User logged in Facebook")
            if (loginCallBack != nil) {
                loginCallBack!(result: result, error: error)
            }
    }
    
   func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User logged out Facebook")
    }
    
    static func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({(connection, result, error) -> Void in
            if ((error) != nil) {
                // Process error
                println("Error: \(error)")
            } else {
                println("fetched user: \(result)")
                let userName: String = result.valueForKey("name") as! String
                println("User Name is: \(userName)")
                var userEmail = result.valueForKey("email") as? NSString
                println("User Email is: \(userEmail)")
            }
        })
    }
    
}
