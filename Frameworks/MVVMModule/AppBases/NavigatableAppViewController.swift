//
//  NavigatableAppViewController.swift
//  MVVMModule
//
//  Created by Ahmad Mahmoud on 02/07/2021.
//

import CoreModule
import ServicesModule

open class NavigatableAppViewController<VM: AppViewModel, Navigator>: AppViewController<VM> {
    
    public private(set) final var navigator: Navigator?
    
    // This function to be used to initialise any ViewController instead of the default initialiser
    // There is no way that I know to make the default initialiser private and initialise it this way.
    public static func create(navigator: Navigator,
                              arg0: Any? = nil,
                              arg1: Any? = nil,
                              arg2: Any? = nil,
                              arg3: Any? = nil,
                              arg4: Any? = nil,
                              arg5: Any? = nil) -> Self {
        let viewController = Self.create()
        viewController.navigator = navigator
        viewController.viewModel = DependencyResolver.resolveOptional(arg0: arg0,
                                                                      arg1: arg1,
                                                                      arg2: arg2,
                                                                      arg3: arg3,
                                                                      arg4: arg4,
                                                                      arg5: arg5)
        return viewController
    }
    
    public override static func create(arg0: Any? = nil,
                                       arg1: Any? = nil,
                                       arg2: Any? = nil,
                                       arg3: Any? = nil,
                                       arg4: Any? = nil,
                                       arg5: Any? = nil) -> Self {
        fatalError("Please use the other create function that accepts navigator param!")
    }
}
