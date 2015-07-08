//
//  FavouriteController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/8/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

class FavouriteViewController: UIViewController {
    
    let tag = TabBarControllerTag.FavouriteControllerTag
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(named: "favourite.png"), tag: tag.hashValue)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    init() {
        super.init(nibName: "FavouriteView", bundle: NSBundle.mainBundle())
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}