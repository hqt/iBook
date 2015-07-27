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
    
    // We can get this param to get info from current loginned user
    var user: GIDGoogleUser? = nil
    
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
    }
    
    // The controller subscribe to this function to get call back after login finish
    // If you dont want logoutCallBack of loginCallBack you can set it to be nil
    func subscribe(loginCallBack: ((user: GIDGoogleUser!, error: NSError?) -> Void)?,
        logoutCallBack: ((user: GIDGoogleUser!, error: NSError?) -> Void)?) {
        self.loginCallBack = loginCallBack
        self.logoutCallBack = logoutCallBack
    }
    
    // The action that will be triggered when the login complete
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (self.loginCallBack != nil) {
                self.user = user
                self.loginCallBack!(user: user, error: error)
            }
    }
    
    // Use this function to logout everywhere at any time
    func logout() {
        if (GIDSignIn.sharedInstance().currentUser != nil) {
            GIDSignIn.sharedInstance().signOut()
            GIDSignIn.sharedInstance().disconnect()
        }
    }
    
    // The action that will be triggered when logout complete
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            if (self.logoutCallBack != nil) {
                self.logoutCallBack!(user: user, error: error)
                self.user = nil
            }
    }
    
}