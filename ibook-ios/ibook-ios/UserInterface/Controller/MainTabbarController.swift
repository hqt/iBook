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
    
    var assembly: ApplicationAssembly!
    var name = ""
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.topItem?.title = name
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        println(item.tag)
    }
    
    init(assembly: ApplicationAssembly!) {
        self.assembly = assembly
        super.init(nibName: nil, bundle: NSBundle.mainBundle())
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        
        let contactController = self.assembly.contactController() as! ContactViewController
        let historyController = self.assembly.historyController() as! HistoryViewController
        let controllers = [contactController, historyController]
        self.viewControllers = controllers
        contactController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Contacts, tag: TAG_CONTACT_CONTROLLER)
        historyController.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.History, tag: TAG_HISTORY_CONTROOLER)
    }
    
}