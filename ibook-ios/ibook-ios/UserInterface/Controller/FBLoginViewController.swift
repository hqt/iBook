//
//  FBLogicViewController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/25/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FBLoginViewController: BaseTextEditViewController, FBSDKLoginButtonDelegate {
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!,
        error: NSError!) {
            println("User Logged In")
            if (error != nil) {
                // Process error
            } else if result.isCancelled {
                // Handle cancellations
            } else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if result.grantedPermissions.contains("email") {
                    // Do work
                }
                self.returnUserData()
            }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({(connection, result, error) -> Void in
            if ((error) != nil) {
                // Process error
                println("Error: \(error)")
            } else {
                println("fetched user: \(result)")
                let userName: String = result.valueForKey("name") as! String
                println("User Name is: \(userName)")
                self.navigationController?.navigationBar.topItem?.title = userName
                var userEmail = result.valueForKey("email") as? NSString
                println("User Email is: \(userEmail)")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor().mainColor()
        navigationController?.navigationBar.topItem?.title = "Login"
        
        // Check login
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            self.returnUserData()
        }
        
        // Login or Logout button
        let loginView: FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
    }

}