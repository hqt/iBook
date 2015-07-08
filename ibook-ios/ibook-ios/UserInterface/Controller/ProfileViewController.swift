//
//  FavouriteController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/8/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

class ProfileViewController: UIViewController {
    
    let tag = TabBarControllerTag.ProfileControllerTag
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    init() {
        super.init(nibName: "ProfileView", bundle: NSBundle.mainBundle())
        tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile.png"), tag: tag.hashValue)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}