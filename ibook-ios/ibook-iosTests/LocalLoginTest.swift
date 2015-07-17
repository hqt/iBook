//
//  LocalLoginTest.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/9/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import UIKit
import XCTest

class LocalLoginTest: XCTestCase {

    var localLoginService: LocalLoginService!
    
    override func setUp() {
        super.setUp()
        localLoginService = LocalLoginService()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testLoginSuccess() {
        
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        
        localLoginService.login("nongdenchet", password: "android", done: {
            (success: Bool, error: NSException?) in
            
            println("Resule: \(success)")
            XCTAssertEqual(success, true, "Expect login success but fail")
            readyExpectation.fulfill()
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func testLoginWithWrongPassword() {
        
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        
        localLoginService.login("apidez", password: "android", done: {
            (success: Bool, error: NSException?) in
            
            XCTAssertEqual(success, false, "Expect login fail but success")
            readyExpectation.fulfill()
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testLoginWithWrongUsername() {
        
        // Declare our expectation
        let readyExpectation = expectationWithDescription("ready")
        
        localLoginService.login("hqt", password: "IBOOK", done: {
            (success: Bool, error: NSException?) in
            
            XCTAssertEqual(success, false, "Expect login fail but success")
            readyExpectation.fulfill()
        })
        
        // Loop until the expectation is fulfilled
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

}
