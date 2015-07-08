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
    var assembly: ApplicationAssembly!
    
    init(assembly: ApplicationAssembly) {
        self.assembly = assembly
        super.init(nibName: "RootView", bundle: NSBundle.mainBundle())
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iBookLabel.text = "Apidez"
        navigationController?.pushViewController(self.assembly.loginViewController() as! LoginViewController,
            animated: false)
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Intro"
    }

}