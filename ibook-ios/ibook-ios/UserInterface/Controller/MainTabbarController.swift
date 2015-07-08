//
//  TabbarViewController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/8/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

class MainTabbarController: UITabBarController {
    
    let TAG_CONTACT_CONTROLLER = 1
    let TAG_HISTORY_CONTROOLER = 2
    var name = ""
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.topItem?.title = name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        
        let contactController = ContactViewController()
        let historyController = HistoryViewController()
        let controllers = [contactController, historyController]
        self.viewControllers = controllers
        contactController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Contacts, tag: TAG_CONTACT_CONTROLLER)
        historyController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.History, tag: TAG_HISTORY_CONTROOLER)
    }
    
}