//
//  GGPLoginService.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/27/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

class GPPLoginService: NSObject, GPPSignInDelegate, ISocialLoginService {
    
    var loginCallBack: ((ticket: GTLServiceTicket!, person: GTLPlusPerson!, error: NSError?) -> Void)? = nil
    var logoutCallBack: ((error: NSError?) -> Void)? = nil
    var person: AnyObject? = nil
    
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
        self.returnUserData()
    }
    
    func didDisconnectWithError(error: NSError!) {
        if (logoutCallBack != nil) {
            logoutCallBack!(error: error)
        }
    }
    
    // The controller subscribe to this function to get call back after login finish
    // If you dont want logoutCallBack of loginCallBack you can set it to be nil
    func subscribe(loginCallBack: ((ticket: GTLServiceTicket!, person: GTLPlusPerson!, error: NSError?) -> Void)?,
        logoutCallBack: ((error: NSError?) -> Void)?) {
            self.loginCallBack = loginCallBack
            self.logoutCallBack = logoutCallBack
    }
    
    func unSubscribe() {
        loginCallBack = nil
        logoutCallBack = nil
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
    
    // Call this function manually to retrieve user info
    // Will update this function in the feature to have a callback for needed data
    func returnUserData() {
        var queryPlus: AnyObject! = GTLQueryPlus.queryForPeopleGetWithUserId("me")
        var plusService = GTLServicePlus()
        plusService.retryEnabled = true
        plusService.authorizer = GPPSignIn.sharedInstance().authentication
        plusService.executeQuery(queryPlus as! GTLQueryPlus) {
            (ticket, person, error) in
            if (self.loginCallBack != nil) {
                self.loginCallBack!(ticket: ticket, person: person as! GTLPlusPerson, error: error)
                self.person = person
            }
        }
    }
}