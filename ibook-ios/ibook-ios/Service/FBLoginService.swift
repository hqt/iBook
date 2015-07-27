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
    
    // MARK: - Shared Instance
    class func sharedInstance() -> FBLoginService {
        struct Singleton {
            static var sharedInstance = FBLoginService()
        }
        return Singleton.sharedInstance
    }
    
    // The controller subscribe to this function to get call back after login finish
    // If you dont want logoutCallBack of loginCallBack you can set it to be nil
    func subscribe(loginCallBack: ((result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void)?,
        logoutCallBack: (() -> Void)?) {
            self.loginCallBack = loginCallBack
            self.logoutCallBack = logoutCallBack
    }
    
    // The action that will be triggered when the login complete
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!,
        error: NSError!) {
            println("User logged in Facebook")
            if (loginCallBack != nil) {
                loginCallBack!(result: result, error: error)
            }
    }
    
    // Use this function to logout everywhere at any time
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
    
    // The action that will be triggered when logout complete
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User logged out Facebook")
        if (logoutCallBack != nil) {
            logoutCallBack!()
        }
    }
    
    // Call this function manually to retrieve user info
    // Will update this function in the feature to have a callback for needed data
    static func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({(connection, result, error) -> Void in
            if ((error) != nil) {
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