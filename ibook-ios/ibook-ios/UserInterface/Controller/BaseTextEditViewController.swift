//
//  BaseViewController.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/9/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

class BaseTextEditViewController: UIViewController {
    
    let offset: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // add observer for keyboard events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // remove observer for keyboard events
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    func keyboardWillShow() {
        if (self.view.frame.origin.y >= 0) {
            setViewMoveUp(true)
        } else {
            setViewMoveUp(false)
        }
    }

    func keyboardWillHide() {
        if (self.view.frame.origin.y >= 0) {
            setViewMoveUp(true)
        } else {
            setViewMoveUp(false)
        }
    }
    
    func setViewMoveUp(movedUp: Bool) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(NSTimeInterval(0.3))
        var rect = self.view.frame;
        if (movedUp) {
            rect.origin.y -= offset
            rect.size.height += offset
        }
        else {
            // revert back to the normal state.
            rect.origin.y += offset
            rect.size.height -= offset
        }
        self.view.frame = rect;
        UIView.commitAnimations()
    }
    
}
