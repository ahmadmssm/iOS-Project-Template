//
//  SwizzlingUtils.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 07/06/2021.
//

import Foundation

class SwizzlingUtils {
    
    static func swizzle(clazz: AnyClass,
                        originalSelector: Selector,
                        newSelector: Selector) {
        if (self.addMethod(clazz: clazz,
                           originalSelector: originalSelector,
                           newSelector: newSelector)) {
            self.replaceMethod(clazz: clazz,
                               originalSelector: originalSelector,
                               newSelector: newSelector)
        }
        else {
            self.exchangeImplementations(clazz: clazz,
                                         originalSelector: originalSelector,
                                         newSelector: newSelector)
        }
    }
    
    static func addMethod(clazz: AnyClass,
                          originalSelector: Selector,
                          newSelector: Selector) -> Bool {
        let newMethod = self.getInstanceMethod(ofClass: clazz, name: newSelector)
        let newMethodImpl = self.getImplementation(ofMethod: newMethod!)
        let newMethodTypeEncoding = self.getTypeEncoding(ofMethod: newMethod!)
        //
        return class_addMethod(clazz, originalSelector, newMethodImpl, newMethodTypeEncoding)
    }
    
    static func replaceMethod(clazz: AnyClass,
                              originalSelector: Selector,
                              newSelector: Selector) {
        let originalMethod = self.getInstanceMethod(ofClass: clazz, name: originalSelector)
        let originalMethodImpl = self.getImplementation(ofMethod: originalMethod!)
        let originalMethodTypeEncoding = self.getTypeEncoding(ofMethod: originalMethod!)
        //
        class_replaceMethod(clazz, newSelector, originalMethodImpl, originalMethodTypeEncoding)
    }
    
    static func exchangeImplementations(clazz: AnyClass,
                                        originalSelector: Selector,
                                        newSelector: Selector) {
        let originalMethod = self.getInstanceMethod(ofClass: clazz, name: originalSelector)
        let newMethod = self.getInstanceMethod(ofClass: clazz, name: newSelector)
        //
        method_exchangeImplementations(originalMethod!, newMethod!)
    }
    
    static func getInstanceMethod(ofClass clazz: AnyClass, name: Selector) -> Method? {
        return class_getInstanceMethod(clazz, name)
    }
    
    static func getImplementation(ofMethod method: Method) -> IMP {
        return method_getImplementation(method)
    }
    
    static func getTypeEncoding(ofMethod method: Method) -> UnsafePointer<CChar>? {
        return method_getTypeEncoding(method)
    }
}
