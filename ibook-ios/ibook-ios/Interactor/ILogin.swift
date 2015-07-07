//
//  ILogin.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/7/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import Foundation

@objc public protocol ILogin {
    func login(username: String!, password: String!, done: (success: Bool) -> Void)
}