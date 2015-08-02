//
//  TestLoginSuccessController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/26/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import UIKit

public enum LoginType {
    case FACEBOOK, GOOGLE_PLUS
}

class TestLoginViewController: BaseTextEditViewController {
    
    var loginType: LoginType? = nil
    
    init(loginType: LoginType) {
        self.loginType = loginType
        super.init(nibName: "TestLogin", bundle: NSBundle.mainBundle())
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.backgroundColor = UIColor.mainColor()
        self.navigationItem.hidesBackButton = true;
        navigationController?.navigationBar.topItem?.title = "Success"
        let logoutBtn = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain,
            target: self, action: Selector("logout"))
        logoutBtn.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = logoutBtn
        
        self.configureFacebook()
        self.configureGooglePlus()
    }
    
    func configureFacebook() {
        FBLoginService.sharedInstance().subscribe(nil, logoutCallBack: {
            () -> Void in
            self.navigateToLogin()
        })
    }
    
    func configureGooglePlus() {
        var gppLoginService = GPPLoginService.sharedInstance()
        GPPSignIn.sharedInstance().delegate = gppLoginService
        gppLoginService.subscribe(nil, logoutCallBack: {
            (error) -> Void in
            if (error == nil) {
                self.navigateToLogin()
            }
        })
    }
    
    // After logout navigate back to login
    func navigateToLogin() {
        var viewControllers: NSMutableArray = NSMutableArray(array: self.navigationController!.viewControllers)
        viewControllers.replaceObjectAtIndex(viewControllers.count - 1,
            withObject: SocialLoginViewController())
        self.navigationController!.setViewControllers(viewControllers as [AnyObject], animated: false)
    }
    
    override func viewDidDisappear(animated: Bool) {
        FBLoginService.sharedInstance().unSubscribe()
        GPPLoginService.sharedInstance().unSubscribe()
    }
    
    func logout() {
        switch (loginType!) {
        case .FACEBOOK:
            FBLoginService.sharedInstance().logout()
        case .GOOGLE_PLUS:
            GPPLoginService.sharedInstance().logout()
        }
    }
    
}