//
//  EnvironmentUtils.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//

public class EnvironmentUtils {
    
    static func doIfDebug(action: () -> Void) {
        #if DEBUG
        action()
        #endif
    }
    
    static func doIfRelease(action: () -> Void) {
        #if !DEBUG
        action()
        #endif
    }
    
    static func doIfDebugOrRelease(debugAction: () -> Void, releaseAction: () -> Void) {
        #if DEBUG
        debugAction()
        #else
        releaseAction()
        #endif
    }
    
    static func doIfStaging(action: () -> Void) {
        #if STAGING
        action()
        #endif
    }
    
    static func doIfProduction(action: () -> Void) {
        #if PRODUCTION
        action()
        #endif
    }
    
    static func doIfStagingOrProduction(stagingAction: () -> Void, productionAction: () -> Void) {
        #if STAGING
        stagingAction()
        #else
        productionAction()
        #endif
    }
}
