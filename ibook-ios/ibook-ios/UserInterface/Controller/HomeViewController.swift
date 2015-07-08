//
//  FavouriteController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/8/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

class HomeViewController: UIViewController {
    
    let tag = TabBarControllerTag.HomeControllerTag
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    init() {
        super.init(nibName: "HomeView", bundle: NSBundle.mainBundle())
        tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home.png"), tag: tag.hashValue)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}