//
//  ApplicationAssemply.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/7/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import Foundation
import Typhoon

@objc(ApplicationAssembly)
public class ApplicationAssembly: TyphoonAssembly {
    
    var services: ServiceAssembly!
    
    // Load properties from a plist
    public dynamic func config() -> AnyObject {
        return TyphoonDefinition.configDefinitionWithName("Configuration.plist")
    }
    
    // At the beginning when the AppDelegate has been created,
    // this function will be used to inject into the AppDelegate
    public dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) {
            (definition) in
            
            definition.injectProperty("assembly", with: self)
        }
    }
    
}
