//
//  GoogleLoginViewController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/25/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import UIKit

class GoogleLoginViewController: BaseTextEditViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor().mainColor()
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = Value.googleClientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        var loginView = GIDSignInButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
    }
    
    // Signin
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                // Perform any operations on signed in user here.
                println("User login")
                let userId = user.userID
                let idToken = user.authentication.idToken
                let name = user.profile.name
                let email = user.profile.email
                self.navigationController?.navigationBar.topItem?.title = name
            } else {
                println("\(error.localizedDescription)")
            }
    }

    // Signout
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            if (error == nil) {
                println("User login")
                self.navigationController?.navigationBar.topItem?.title = "Login"
            } else {
                println("\(error.localizedDescription)")
            }
    }
    
    // Implement these methods only if the GIDSignInUIDelegate is not a subclass of
    // UIViewController.
    
    // Stop the UIActivityIndicatorView animation that was started when the user
    // pressed the Sign In button
    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
        // myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func signIn(signIn: GIDSignIn!,
        presentViewController viewController: UIViewController!) {
            self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func signIn(signIn: GIDSignIn!,
        dismissViewController viewController: UIViewController!) {
            self.dismissViewControllerAnimated(true, completion: nil)
    }
}
