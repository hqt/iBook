//
//  ApplicationAssemply.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/7/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import Foundation

@objc(ApplicationAssembly)
public class ApplicationAssembly: TyphoonAssembly {
    
    // Load properties from a plist
    public dynamic func config() -> AnyObject {
        return TyphoonDefinition.configDefinitionWithName("Configuration.plist")
    }
    
    // At the beginning when the AppDelegate has been created,
    // this function will be used to inject into the AppDelegate
    public dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) {
            (definition) in
            
            // definition.injectProperty("window", with: self.mainWindow())
            definition.injectProperty("rootViewController", with: self.rootViewController())
        }
    }
    
    // This will hold the single instance rootViewController
    // The whole application will contain only one rootViewController
    public dynamic func rootViewController() -> AnyObject {
        return TyphoonDefinition.withClass(RootViewController.self) {
            (definition) in

            // inject with constructor
            definition.useInitializer("initWithAssembly:") {
                (initializer) in
                
                initializer.injectParameterWith(self)
            }
            definition.scope = TyphoonScope.Singleton
        }
    }
    
    public dynamic func localLogin() -> AnyObject {
        return TyphoonDefinition.withClass(LocalLoginImp.self)
    }
    
    public dynamic func loginViewController() -> AnyObject {
        return TyphoonDefinition.withClass(LoginViewController.self) {
            (definition) in
            
            definition.useInitializer("initWithInteractor:") {
                (initializer) in
                
                initializer.injectParameterWith(self.localLogin())
            }
            definition.injectProperty("profileViewController", with: self.profileViewController())
            definition.injectProperty("tabbarController", with: self.tabbarController())
        }
    }
    
    public dynamic func profileViewController() -> AnyObject {
        return TyphoonDefinition.withClass(ProfileViewController.self) {
            (definition) in
            
            definition.useInitializer("init")
        }
    }
    
    public dynamic func tabbarController() -> AnyObject {
        return TyphoonDefinition.withClass(MainTabbarController.self)
    }
    
//    public dynamic func remoteLogin() -> AnyObject {
//        return TyphoonDefinition.withClass(RemoteLoginImp.self)
//    }
    
//    // TODO: why cannot use constructor injection for UIWindow in Swift, but work fine on Objective-C
//    // The main window if the application
//    public dynamic func mainWindow() -> AnyObject {
//        return TyphoonDefinition.withClass(UIWindow.self) {
//            (definition) in
//            
//            definition.useInitializer("initWithFrame:") {
//                (initializer) in
//                
//                initializer.injectParameterWith(UIScreen.mainScreen().bounds)
//            }
//            definition.injectProperty("rootViewController", with: self.rootViewController())
//        }
//    }
}
