//
//  LoginController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/7/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginService: ILoginService!
    var tabbarController: TabBarViewController!
    var assembly: ServiceAssembly!
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var infoTitle: UILabel!
    
    init() {
        super.init(nibName: "LoginView", bundle: NSBundle.mainBundle())
        assembly = ServiceAssembly().activate()
        loginService = assembly.loginService() as! LocalLoginService
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progress.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "Login"
    }
    
    @IBAction func userNameDoneEdit(sender: AnyObject) {
        sender.resignFirstResponder()
    }
    
    @IBAction func passwordDoneEdit(sender: AnyObject) {
        sender.resignFirstResponder()
    }
    
    func startLogin() {
        loginButton.hidden = true
        passwordTxt.hidden = true
        usernameTxt.hidden = true
        progress.hidden = false
        infoTitle.textColor = UIColor.blackColor()
        infoTitle.text = "Loging in..."
        progress.startAnimating()
    }
    
    func finishLogin() {
        loginButton.hidden = false
        passwordTxt.hidden = false
        usernameTxt.hidden = false
        progress.hidden = true
        progress.stopAnimating()
    }
    
    // Add tab bar controller
    func addTabbarController() {
        let nav = self.navigationController!
        tabbarController = TabBarViewController()
        nav.popViewControllerAnimated(false)
        nav.pushViewController(self.tabbarController, animated: true)
    }
    
    @IBAction func login(sender: UIButton) {
        self.startLogin()
        passwordTxt.resignFirstResponder()
        usernameTxt.resignFirstResponder()
        loginService.login(usernameTxt.text, password: passwordTxt.text, done: {
            (success: Bool) in
            
            self.finishLogin()
            if success {
                self.addTabbarController()
            } else {
                self.infoTitle.text = "Username or password is wrong"
                self.infoTitle.textColor = UIColor.redColor()
            }
        })
    }
}