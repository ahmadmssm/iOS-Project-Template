//
//  NetworkLoaderOverlay.swift
//  CustomComponentsModule
//
//  Created by Ahmad Mahmoud on 11/03/2021.
//

import UIKit

public class NetworkLoaderOverlay {
    
    private let loadingSpinner: FPActivityLoader = {
        let view = FPActivityLoader(frame: CGRect(x: 0, y: 0, width: 87, height: 87))
        view.strokeColor = .white
        view.lineWidth = 5
        return view
    }()
    private let loadingOverlayView: UIView = UIView(frame: UIScreen.main.bounds)
    
    public init(backgroundColor: UIColor) {
        self.addAndCenterSubViews()
        self.loadingOverlayView.backgroundColor = backgroundColor
    }
    
    public func show() {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(self.loadingOverlayView)
        }
        self.loadingSpinner.animating = true
    }
    
    public func hide() {
        if(!self.loadingOverlayView.isHidden) {
            self.loadingSpinner.animating = false
            self.loadingOverlayView.removeFromSuperview()
        }
    }
    
    private func addAndCenterSubViews() {
        let appLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
        let parentViewBounds = self.loadingOverlayView.bounds
        let parentViewPosition = CGPoint(x: parentViewBounds.width / 2, y: parentViewBounds.height / 2)
        self.loadingOverlayView.center = parentViewPosition
        appLogo.center = CGPoint(x: self.loadingSpinner.bounds.width / 2, y: self.loadingSpinner.bounds.height / 2)
        appLogo.image = #imageLiteral(resourceName: "octocat")
        self.loadingOverlayView.addSubview(self.loadingSpinner)
        self.loadingSpinner.center = parentViewPosition
        self.loadingSpinner.addSubview(appLogo)
    }
}
