//
//  NSObject+ClassName.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 26/02/2021.
//

import Foundation

public extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
