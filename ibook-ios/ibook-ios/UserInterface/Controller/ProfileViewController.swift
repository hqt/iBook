//
//  ProfileViewController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/7/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import Foundation

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    var username = ""
    
    init() {
        super.init(nibName: "ProfileView", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = username
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Profile"
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
}