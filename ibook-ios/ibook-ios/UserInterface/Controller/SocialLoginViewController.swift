//
//  FBLogicViewController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/25/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SocialLoginViewController: BaseTextEditViewController, GIDSignInUIDelegate {
    
    var fbLoginService: FBLoginService
    var ggLoginService: GGLoginService
    
    init() {
        ggLoginService = GGLoginService()
        fbLoginService = FBLoginService()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        ggLoginService = GGLoginService()
        fbLoginService = FBLoginService()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.mainColor()
        navigationController?.navigationBar.topItem?.title = "Login to iBook"
        
        // Login process
        if (!self.checkLogin()) {
            self.configureGoogle()
            self.configureFacebook()
        }
    }
    
    func checkLogin() -> Bool {
        // Check login
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            println("User had been login with Facebook")
            return true
        } else if (GIDSignIn.sharedInstance().currentUser != nil) {
            println("User had been login with Google")
            return true
        }
        return false
    }
    
    func configureFacebook() {
        // Login facebook
        var loginViewFB: FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginViewFB)
        loginViewFB.frame.size.width = 300
        loginViewFB.frame.size.height = 42
        loginViewFB.center = CGPointMake(self.view.center.x, 530)
        loginViewFB.readPermissions = ["public_profile", "email", "user_friends"]
        loginViewFB.delegate = fbLoginService
        
        // Callback login
        fbLoginService.subscribe({
            (result: FBSDKLoginManagerLoginResult!, error: NSError!) in
            if (error == nil && !result.isCancelled) {
                println("User had been login with Facebook")
                self.navigateToMainController(LoginType.FACEBOOK)
            }
        }, logoutCallBack: nil)
    }
    
    func configureGoogle() {
        // Login google
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = ggLoginService
        var loginViewGG = GIDSignInButton()
        loginViewGG.frame.size.width = 300
        loginViewGG.frame.size.height = 40
        self.view.addSubview(loginViewGG)
        loginViewGG.center = CGPointMake(self.view.center.x, 480)
        
        // Callback login
        ggLoginService.subscribe({
            (user, error) -> Void in
            if (error == nil && user != nil) {
                println("User had been login with Google")
                self.navigateToMainController(LoginType.GOOGLE)
            }
        }, logoutCallBack: nil)
    }
    
    func navigateToMainController(loginType: LoginType!) {
        self.navigationController!.popViewControllerAnimated(false)
        self.navigationController!.pushViewController(TestLoginViewController(loginType: loginType), animated: true)
    }
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }

}