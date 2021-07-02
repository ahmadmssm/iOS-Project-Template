//
//  main.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//
// Ref: https://qualitycoding.org/ios-app-delegate-testing/

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("UnitTestingAppDelegate") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
