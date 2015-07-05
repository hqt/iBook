//
//  ViewController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/5/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var iBookLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        iBookLabel.text = "APIDEZ"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

