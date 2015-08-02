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
    
    var fbLoginService: FBLoginService = FBLoginService.sharedInstance()
    var gppLoginService: GPPLoginService = GPPLoginService.sharedInstance()
    
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    
    init() {
        super.init(nibName: "SocialLoginView", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI();
        self.configureGooglePlus()
        self.configureFacebook()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.backgroundColor = UIColor.mainColor()
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.topItem?.title = "Login to iBook"
    }
    
    func setUpUI() {
        facebookBtn.layer.borderWidth = 2
        facebookBtn.layer.borderColor = UIColor.whiteColor().CGColor
        facebookBtn.layer.cornerRadius = 10
        googleBtn.layer.borderWidth = 2
        googleBtn.layer.borderColor = UIColor.whiteColor().CGColor
        googleBtn.layer.cornerRadius = 10
    }
    
    @IBAction func loginFacebook(sender: AnyObject) {
        fbLoginService.login()
    }
    
    @IBAction func loginGoogle(sender: AnyObject) {
        gppLoginService.login()
    }
    
    // configure facebook login
    func configureFacebook() {
        // Check user has authenticate?
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
        
        // Relogin
        GPPSignIn.sharedInstance().trySilentAuthentication()
    }
    
    // Navigate to the next controller
    func navigateToMainController(loginType: LoginType!) {
        var viewControllers: NSMutableArray = NSMutableArray(array: self.navigationController!.viewControllers)
        viewControllers.replaceObjectAtIndex(viewControllers.count - 1,
            withObject: TestLoginViewController(loginType: loginType))
        self.navigationController!.setViewControllers(viewControllers as [AnyObject], animated: false)
    }
    
}