//
//  GGLoginService.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/26/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

class GGLoginService: NSObject, GIDSignInDelegate {
    
    var loginCallBack: ((user: GIDGoogleUser!, error: NSError?) -> Void)? = nil
    var logoutCallBack: ((user: GIDGoogleUser!, error: NSError?) -> Void)? = nil
    
    // MARK: - Shared Instance
    class func sharedInstance() -> GGLoginService {
        struct Singleton {
            static var sharedInstance = GGLoginService()
        }
        return Singleton.sharedInstance
    }
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().clientID = Value.googleClientID
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func subscribe(loginCallBack: ((user: GIDGoogleUser!, error: NSError?) -> Void)?,
        logoutCallBack: ((user: GIDGoogleUser!, error: NSError?) -> Void)?) {
        self.loginCallBack = loginCallBack
        self.logoutCallBack = logoutCallBack
    }
    
    // Signin
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            self.loginCallBack!(user: user, error: error)
    }
    
    func logout() {
        if (GIDSignIn.sharedInstance().currentUser != nil) {
            GIDSignIn.sharedInstance().signOut()
            GIDSignIn.sharedInstance().disconnect()
        }
    }
    
    // Signout
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            self.logoutCallBack!(user: user, error: error)
    }
    
}