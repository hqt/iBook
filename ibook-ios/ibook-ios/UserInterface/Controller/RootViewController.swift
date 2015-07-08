//
//  ViewController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/5/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet weak var iBookLabel: UILabel!
    
    init() {
        super.init(nibName: "RootView", bundle: NSBundle.mainBundle())
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change font color of status bar
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        
        // create login controller
        let viewController = LoginViewController()
        viewController.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.pushViewController(viewController, animated: false)
    }

}