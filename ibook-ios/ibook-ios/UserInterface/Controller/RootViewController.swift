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
        super.init(nibName: "RootView", bundle: NSBundle.mainBundle())
        self.assembly = assembly
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}