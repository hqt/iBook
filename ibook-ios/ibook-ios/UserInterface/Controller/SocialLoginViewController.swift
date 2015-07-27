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

class SocialLoginViewController: BaseTextEditViewController {
    
    // var ggLoginService: GGLoginService = GGLoginService.sharedInstance()
    var fbLoginService: FBLoginService = FBLoginService.sharedInstance()
    var gppLoginService: GPPLoginService = GPPLoginService.sharedInstance()
    var loginViewGPP: GPPSignInButton? = nil
    var loginViewFB: FBSDKLoginButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI();
        self.configureGooglePlus()
        self.configureFacebook()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.backgroundColor = UIColor.mainColor()
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.topItem?.title = "Login to iBook"
    }
    
    // Configure UI
    func configureUI() {
        // Facebook login button
        loginViewGPP = GPPSignInButton()
        loginViewGPP!.frame.size.width = 300
        loginViewGPP!.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(loginViewGPP!)
        
        // Google plus login button
        loginViewFB = FBSDKLoginButton()
        loginViewFB!.readPermissions = ["public_profile", "email", "user_friends"]
        loginViewFB!.delegate = fbLoginService
        loginViewFB!.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(loginViewFB!)
        
        // Constraints
        var viewsDictionary = [
            "fb" : loginViewFB!,
            "gg" : loginViewGPP!
        ]
        
        // Facebook horizontal constraints
        let fb_constraint_V: Array = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[fb(40)]",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewsDictionary
        )
        loginViewFB!.addConstraints(fb_constraint_V)
        
        // Google plus horizontal constraints
        let gg_constraint_V: Array = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[gg(42)]",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewsDictionary
        )
        loginViewGPP!.addConstraints(gg_constraint_V)
        
        // Horizontal constrainst
        let fb_align_H: Array = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[fb]-|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewsDictionary
        )
        let gg_align_H: Array = NSLayoutConstraint.constraintsWithVisualFormat(
            "H:|-[gg]-|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewsDictionary
        )
        view.addConstraints(fb_align_H)
        view.addConstraints(gg_align_H)
        
        // Vertical constraints
        let align_V: Array = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:[gg]-[fb]-|",
            options: NSLayoutFormatOptions(0),
            metrics: nil,
            views: viewsDictionary
        )
        view.addConstraints(align_V)
    }
    
    // configure facebook login
    func configureFacebook() {
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            println("User has been login with Facebook")
            self.navigationController?.pushViewController(TestLoginViewController(loginType: LoginType.FACEBOOK),
                animated: false)
        }
        
        // Callback login, we set callback logout to nil, because we dont need it
        fbLoginService.subscribe({
            (result: FBSDKLoginManagerLoginResult!, error: NSError!) in
            if (error == nil && !result.isCancelled) {
                println("User has been login with Facebook")
                self.navigateToMainController(LoginType.FACEBOOK)
            }
        }, logoutCallBack: nil)
    }
    
    // configure google plus login
    func configureGooglePlus() {
        GPPSignIn.sharedInstance().delegate = gppLoginService
        
        // Callback login, we set callback logout to nil, because we dont need it
        gppLoginService.subscribe({
            (auth, error) -> Void in
            if (error == nil && auth != nil) {
                println("User has been login with Google")
                self.navigateToMainController(LoginType.GOOGLE_PLUS)
            }
            }, logoutCallBack: nil)
        GPPSignIn.sharedInstance().trySilentAuthentication()
    }
    
    // Navigate to the next controller
    func navigateToMainController(loginType: LoginType!) {
        var viewControllers: NSMutableArray = NSMutableArray(array: self.navigationController!.viewControllers)
        viewControllers.replaceObjectAtIndex(viewControllers.count - 1,
            withObject: TestLoginViewController(loginType: loginType))
        self.navigationController!.setViewControllers(viewControllers as [AnyObject], animated: false)
    }
    
    //    // configure google login
    //    func configureGoogle() {
    //        // Login google
    //        GIDSignIn.sharedInstance().uiDelegate = self
    //        GIDSignIn.sharedInstance().delegate = ggLoginService
    //
    //        // Login button
    //        var loginViewGG = GIDSignInButton()
    //        loginViewGG.frame.size.width = 300
    //        loginViewGG.frame.size.height = 40
    //        loginViewGG.center = CGPointMake(self.view.center.x, 480)
    //        self.view.addSubview(loginViewGG)
    //
    //        // Callback login, we set callback logout to nil, because we dont need it
    //        ggLoginService.subscribe({
    //            (user, error) -> Void in
    //            if (error == nil && user != nil) {
    //                println("User has been login with Google")
    //                self.navigateToMainController(LoginType.GOOGLE)
    //            }
    //        }, logoutCallBack: nil)
    //        GIDSignIn.sharedInstance().signInSilently()
    //    }
    
}