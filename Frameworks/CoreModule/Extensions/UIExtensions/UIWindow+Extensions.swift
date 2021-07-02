//
//  UIWindow+Extensions.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 17/06/2021.
//

import UIKit

public extension UIWindow {
    
    func blurScreen(style: UIBlurEffect.Style = UIBlurEffect.Style.regular) {
        let screen = UIScreen.main.snapshotView(afterScreenUpdates: false)
        screen.tag = -9779
        let blurEffect = UIBlurEffect(style: style)
        let blurBackground = UIVisualEffectView(effect: blurEffect)
        screen.addSubview(blurBackground)
        blurBackground.frame = (screen.frame)
        window?.addSubview(screen)
    }

    func removeBlurScreen() {
        if let blurView = self.subviews.first(where: { $0.tag == -9779 }) {
            blurView.removeFromSuperview()
        }
    }
}
