//
//  TabbarViewController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/8/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

enum TabBarControllerTag: Int {
    case FavouriteControllerTag
    case DraftControllerTag
    case HomeControllerTag
    case NotifyControllerTag
    case ProfileControllerTag
}

class TabBarViewController: UITabBarController {

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.topItem?.title = "iBook"
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        println(item.tag)
    }
    
    init() {
        super.init(nibName: nil, bundle: NSBundle.mainBundle())
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        
        // add controllers
        let controllers = [FavouriteViewController(), DraftViewController(), HomeViewController(), NotifyViewController(), ProfileViewController()]
        self.viewControllers = controllers
        self.selectedIndex = TabBarControllerTag.HomeControllerTag.hashValue
        
        // add search button
        let searchBtn = UIBarButtonItem(image: UIImage(named: "search.png"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("search"))
        self.navigationItem.rightBarButtonItem = searchBtn
    }
    
    func search() {
        println("Searching")
    }
}