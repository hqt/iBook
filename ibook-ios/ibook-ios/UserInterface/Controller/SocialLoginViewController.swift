//
//  FBLogicViewController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/25/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import SVProgressHUD
import UIKit
import PromiseKit
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
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.backgroundColor = UIColor.mainColor()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.topItem?.title = "Login to iBook"
        self.configureGooglePlus()
        self.configureFacebook()
    }
    
    override func viewDidDisappear(animated: Bool) {
        fbLoginService.unSubscribe()
        gppLoginService.unSubscribe()
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
            self.navigateToMainController(LoginType.FACEBOOK)
        }
        
        // Callback login, we set callback logout to nil, because we dont need it
        fbLoginService.subscribe({
            (connection, result, error) in
            println(result.valueForKey("id") as! String)
            self.authenticateWithServer(LoginType.FACEBOOK, socialUserId: 1)
        }, logoutCallBack: nil)
    }
    
    // configure google plus login
    func configureGooglePlus() {
        // Callback login, we set callback logout to nil, because we dont need it
        GPPSignIn.sharedInstance().delegate = gppLoginService
        GPPSignIn.sharedInstance().trySilentAuthentication()
        gppLoginService.subscribe({
            (ticket, person, error) in
            println(person.identifier)
            self.authenticateWithServer(LoginType.GOOGLE_PLUS, socialUserId: 1)
        }, logoutCallBack: nil)
    }
    
    // Authenticate with server
    func authenticateWithServer(loginType: LoginType!, socialUserId: Int) {
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Black)
        
        // Construct param
        var params: [String : AnyObject!] = [
            PARAM_LOGIN.PRIVATE_KEY : Value.privateKey,
            PARAM_LOGIN.PROVIDER : loginType == LoginType.FACEBOOK
                ? PARAM_LOGIN.FACEBOOK_PROVIDER : PARAM_LOGIN.GOOGLE_PROVIDER,
            PARAM_LOGIN.SOCIAL_USER_ID : socialUserId
        ]
        
        // Post to server
        NSURLConnection.POST(AppDelegate.server + PARAM_LOGIN.URL, JSON: params)
            .then {
                (body: NSDictionary!) in
                self.handleResult(body, loginType: loginType)
            }.catch(policy: CatchPolicy.AllErrors) {
                error in
                println(error.localizedDescription)
                self.alertError()
        }
    }
    
    // FIXME: problem with closure in PromiseKit - Swift ---> It is a fucking compiler
    func handleResult(body: NSDictionary!, loginType: LoginType!) {
        if (body[PARAM_LOGIN.ERROR] != nil) {
            println(body[PARAM_LOGIN.ERROR])
            self.alertError()
        } else {
            println(body[PARAM_LOGIN.USER_ID])
            println(body[PARAM_LOGIN.RESULT])
            self.navigateToMainController(loginType)
        }
    }
    
    // Alert error
    func alertError() {
        SVProgressHUD.dismiss()
        var alert = UIAlertController(title: "Cannot connect to server", message: "Please check your connection",
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    // Navigate to the next controller
    func navigateToMainController(loginType: LoginType!) {
        SVProgressHUD.dismiss()
        var viewControllers: NSMutableArray = NSMutableArray(array: self.navigationController!.viewControllers)
        viewControllers.replaceObjectAtIndex(viewControllers.count - 1,
            withObject: TestLoginViewController(loginType: loginType))
        self.navigationController!.setViewControllers(viewControllers as [AnyObject], animated: false)
    }
    
}