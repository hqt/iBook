//
//  FavouriteController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/8/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

class NotifyViewController: UIViewController {
    
    let tag = TabBarControllerTag.NotifyControllerTag
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    init() {
        super.init(nibName: "NotifyView", bundle: NSBundle.mainBundle())
        tabBarItem = UITabBarItem(title: "Notify", image: UIImage(named: "notifs.png"), tag: tag.hashValue)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}