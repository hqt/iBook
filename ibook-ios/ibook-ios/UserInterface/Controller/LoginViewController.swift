//
//  LoginController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/7/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var interactor: ILogin!
    var profileViewController: ProfileViewController!
    var tabbarController: MainTabbarController!
    
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var infoTitle: UILabel!
    
    init(interactor: ILogin) {
        super.init(nibName: "LoginView", bundle: NSBundle.mainBundle())
        self.interactor = interactor
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
        navigationItem.setHidesBackButton(true, animated: false)
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
    
    func addProfileController() {
        let nav = self.navigationController!
        self.profileViewController.username = self.usernameTxt.text
        nav.popViewControllerAnimated(false)
        nav.pushViewController(self.profileViewController, animated: true)
    }
    
    func addTabbarController() {
        let nav = self.navigationController!
        self.tabbarController.name = self.usernameTxt.text
        nav.popViewControllerAnimated(false)
        nav.pushViewController(self.tabbarController, animated: true)
    }
    
    @IBAction func login(sender: UIButton) {
        self.startLogin()
        interactor.login(usernameTxt.text, password: passwordTxt.text, done: {
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