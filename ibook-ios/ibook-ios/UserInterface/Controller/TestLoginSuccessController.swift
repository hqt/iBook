//
//  TestLoginSuccessController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/26/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import UIKit

public enum LoginType {
    case FACEBOOK, GOOGLE
}

class TestLoginViewController: BaseTextEditViewController {
    
    var loginType: LoginType? = nil
    var fbLoginService: FBLoginService = FBLoginService.sharedInstance()
    var ggLoginService: GGLoginService = GGLoginService.sharedInstance()
    
    init(loginType: LoginType) {
        self.loginType = loginType
        super.init(nibName: "TestLogin", bundle: NSBundle.mainBundle())
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureFacebook()
        self.configureGoogle()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.backgroundColor = UIColor.mainColor()
        self.navigationItem.hidesBackButton = true;
        navigationController?.navigationBar.topItem?.title = "Success"
        let logoutBtn = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain,
            target: self, action: Selector("logout"))
        logoutBtn.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = logoutBtn
    }
    
    func configureFacebook() {
        fbLoginService.subscribe(nil, logoutCallBack: {
            () -> Void in
            self.navigateToLogin()
        })
    }
    
    func configureGoogle() {
        GIDSignIn.sharedInstance().delegate = ggLoginService
        ggLoginService.subscribe(nil, logoutCallBack: {
            (user, error) -> Void in
            if (error == nil) {
                self.navigateToLogin()
            }
        })
    }
    
    func navigateToLogin() {
        var viewControllers: NSMutableArray = NSMutableArray(array: self.navigationController!.viewControllers)
        viewControllers.replaceObjectAtIndex(viewControllers.count - 1,
            withObject: SocialLoginViewController())
        self.navigationController!.setViewControllers(viewControllers as [AnyObject], animated: false)
    }
    
    func logout() {
        switch (loginType!) {
        case .FACEBOOK:
            fbLoginService.logout()
        case .GOOGLE:
            ggLoginService.logout()
        }
    }
    
}