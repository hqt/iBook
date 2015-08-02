//
//  GGPLoginService.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/27/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

class GPPLoginService: NSObject, GPPSignInDelegate, ISocialLoginService {
    
    var loginCallBack: ((auth: GTMOAuth2Authentication!, error: NSError?) -> Void)? = nil
    var logoutCallBack: ((error: NSError?) -> Void)? = nil
    
    // We can get this param to get info from current loginned user
    var auth: GTMOAuth2Authentication? = nil
    
    // MARK: - Shared Instance
    class func sharedInstance() -> GPPLoginService {
        struct Singleton {
            static var sharedInstance = GPPLoginService()
        }
        return Singleton.sharedInstance
    }
    
    override init() {
        super.init()
        GPPSignIn.sharedInstance().clientID = Value.googleClientID
    }
    
    func finishedWithAuth(auth: GTMOAuth2Authentication!, error: NSError!) {
        if (loginCallBack != nil) {
            self.auth = auth
            loginCallBack!(auth: auth, error: error)
        }
    }
    
    func didDisconnectWithError(error: NSError!) {
        if (logoutCallBack != nil) {
            logoutCallBack!(error: error)
        }
    }
    
    // The controller subscribe to this function to get call back after login finish
    // If you dont want logoutCallBack of loginCallBack you can set it to be nil
    func subscribe(loginCallBack: ((auth: GTMOAuth2Authentication!, error: NSError?) -> Void)?,
        logoutCallBack: ((error: NSError?) -> Void)?) {
            self.loginCallBack = loginCallBack
            self.logoutCallBack = logoutCallBack
    }
    
    // Use this function to logout anytime
    func logout() {
        if (GPPSignIn.sharedInstance().authentication != nil) {
            GPPSignIn.sharedInstance().signOut()
            GPPSignIn.sharedInstance().disconnect()
        }
    }
    
    // Use this function to login anytime
    func login() {
        GPPSignIn.sharedInstance().authenticate()
    }
}