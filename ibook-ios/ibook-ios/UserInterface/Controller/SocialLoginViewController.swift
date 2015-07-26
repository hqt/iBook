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
    
    var fbLoginService: FBLoginService = FBLoginService.sharedInstance()
    var ggLoginService: GGLoginService = GGLoginService.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureGoogle()
        self.configureFacebook()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.backgroundColor = UIColor.mainColor()
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.topItem?.title = "Login to iBook"
    }
    
    func configureFacebook() {
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            println("User has been login with Facebook")
            self.navigationController?.pushViewController(TestLoginViewController(loginType: LoginType.FACEBOOK),
                animated: true)
        }
        
        // Login facebook
        var loginViewFB: FBSDKLoginButton = FBSDKLoginButton()
        loginViewFB.frame.size.width = 300
        loginViewFB.frame.size.height = 42
        loginViewFB.center = CGPointMake(self.view.center.x, 530)
        loginViewFB.readPermissions = ["public_profile", "email", "user_friends"]
        loginViewFB.delegate = fbLoginService
        self.view.addSubview(loginViewFB)
        
        // Callback login
        fbLoginService.subscribe({
            (result: FBSDKLoginManagerLoginResult!, error: NSError!) in
            if (error == nil && !result.isCancelled) {
                println("User has been login with Facebook")
                self.navigateToMainController(LoginType.FACEBOOK)
            }
        }, logoutCallBack: nil)
    }
    
    func configureGoogle() {
        // Login google
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = ggLoginService
        
        // Login button
        var loginViewGG = GIDSignInButton()
        loginViewGG.frame.size.width = 300
        loginViewGG.frame.size.height = 40
        loginViewGG.center = CGPointMake(self.view.center.x, 480)
        self.view.addSubview(loginViewGG)
        
        // Callback login
        ggLoginService.subscribe({
            (user, error) -> Void in
            if (error == nil && user != nil) {
                println("User has been login with Google")
                self.navigateToMainController(LoginType.GOOGLE)
            }
        }, logoutCallBack: nil)
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    func navigateToMainController(loginType: LoginType!) {
        var viewControllers: NSMutableArray = NSMutableArray(array: self.navigationController!.viewControllers)
        viewControllers.replaceObjectAtIndex(viewControllers.count - 1,
            withObject: TestLoginViewController(loginType: loginType))
        self.navigationController!.setViewControllers(viewControllers as [AnyObject], animated: false)
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