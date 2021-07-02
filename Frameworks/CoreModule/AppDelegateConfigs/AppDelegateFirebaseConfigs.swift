//
//  AppDelegateFirebaseConfigs.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 13/06/2021.
//

import UIKit
import Firebase

public class AppDelegateFirebaseConfigs: BaseAppDelegateConfig {
    
    public func application(_ application: UIApplication,
                            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
