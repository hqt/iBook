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
    
    init(loginType: LoginType!) {
        self.loginType = loginType
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.mainColor()
        self.navigationController?.navigationBar.topItem?.title = "Success"
        let searchBtn = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain,
            target: self, action: Selector("logout"))
        self.navigationItem.rightBarButtonItem = searchBtn
    }
    
    func logout() {
        println("Hello World")
    }
    
}