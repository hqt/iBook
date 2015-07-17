//
//  ServiceAssembly.swift
//  ibook-ios
//
//  Created by nongdenchet on 7/8/15.
//  Copyright (c) 2015 apidez. All rights reserved.
//

import Typhoon

@objc(ServiceAssembly)
public class ServiceAssembly: TyphoonAssembly {

    public dynamic func loginService() -> AnyObject {
        return TyphoonDefinition.withClass(LocalLoginService.self)
    }

    //    public dynamic func loginService() -> AnyObject {
    //        return TyphoonDefinition.withClass(RemoteLoginImp.self)
    //    }
}
