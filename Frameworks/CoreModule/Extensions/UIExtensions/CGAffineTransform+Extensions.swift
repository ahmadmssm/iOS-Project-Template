//
//  CGAffineTransform+Extensions.swift.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 02/03/2021.
//

import UIKit

public extension CGAffineTransform {
    
    static var rotateClockwise: CGAffineTransform {
        return CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
    }
   
    static var rotateAntiClockwise: CGAffineTransform {
        return CGAffineTransform(rotationAngle: CGFloat(Double.pi*4))
    }
}
