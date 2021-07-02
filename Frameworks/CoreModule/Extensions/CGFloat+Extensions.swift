//
//  CGFloat+Extensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 10/03/2021.
//

import UIKit

public extension CGFloat {
    func roundToDecimal(_ fractionDigits: Int) -> CGFloat {
        let multiplier = pow(10, Double(fractionDigits))
        return CGFloat(Darwin.round(Double(self) * multiplier) / multiplier)
    }
}
