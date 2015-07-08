//
//  FavouriteController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/8/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

class DraftViewController: UIViewController {
    
    let tag = TabBarControllerTag.DraftControllerTag
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    init() {
        super.init(nibName: "DraftView", bundle: NSBundle.mainBundle())
        tabBarItem = UITabBarItem(title: "Draft", image: UIImage(named: "draft.png"), tag: tag.hashValue)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}