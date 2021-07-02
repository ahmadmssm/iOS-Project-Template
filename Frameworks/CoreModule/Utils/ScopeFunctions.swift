//
//  ScopeFunctions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 20/02/2021.
//
// Ref:- https://akiwang.com/blog/20201030_swift_scope_functions/
/*
 
 Those extensions eases setting different properties of the same object
 Ex:
 We can do this:
 IQKeyboardManager.shared.apply {
 $0.enable = true
 $0.shouldResignOnTouchOutside = true
 $0.shouldShowToolbarPlaceholder = false
 $0.enableAutoToolbar = false
 }
 Instead of this
 IQKeyboardManager.shared..enable = true
 IQKeyboardManager.shared.shouldResignOnTouchOutside = true
 IQKeyboardManager.shouldShowToolbarPlaceholder = false
 IQKeyboardManager.shared.enableAutoToolbar = false
 */

import Foundation

public protocol ScopeFunctions {}

public extension ScopeFunctions {
    
    @discardableResult
    func apply(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
    
    @discardableResult
    func `let`<R>(block: (Self) -> R) -> R? {
        return block(self)
    }
}

public extension Optional where Wrapped: ScopeFunctions { }
//
extension NSObject: ScopeFunctions {}
extension Array: ScopeFunctions {}
extension String: ScopeFunctions {}
extension String.SubSequence: ScopeFunctions {}
extension Int: ScopeFunctions {}
extension Float: ScopeFunctions {}
extension Double: ScopeFunctions {}
extension Bool: ScopeFunctions {}
