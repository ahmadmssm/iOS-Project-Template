//
//  BottomSheetConfigs.swift
//  CustomComponentsModule
//
//  Created by Ahmad Mahmoud on 20/05/2021.
//

import UIKit

public struct BottomSheetConfigs {
    
    let minHeight: CGFloat
    let maxHeight: CGFloat
    
    public init(initialHeight: CGFloat, maxHeight: CGFloat) {
        self.minHeight = initialHeight
        self.maxHeight = maxHeight
    }
}
