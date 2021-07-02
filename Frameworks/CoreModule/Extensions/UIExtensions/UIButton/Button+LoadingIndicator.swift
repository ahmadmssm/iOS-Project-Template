//
//  Button+LoadingIndicator.swift
//  CoreModule
//
//  Created by Ahmad Mahmoud on 5/25/20.
//

import Foundation
import UIKit

public protocol IndicatorButton {
    func stopAnimating()
    func startAnimating(color: UIColor)
    func startWhiteAnimating()
    func startAnimating()
}

extension UIButton: IndicatorButton {
    
    private static var indicatorTag: Int = .max

    private var indicator: UIActivityIndicatorView {
        let view = self.viewWithTag(UIButton.indicatorTag) as? UIActivityIndicatorView
        let indicator = view ?? UIActivityIndicatorView()

        indicator.tag = UIButton.indicatorTag
        indicator.hidesWhenStopped = true
        self.addSubview(indicator)
        indicator.center = CGPoint(x: self.bounds.size.width/2,
                                   y: self.bounds.size.height/2)
        self.bringSubviewToFront(indicator)
        return indicator
    }

    private func setIndicatorStyle(_ style: UIActivityIndicatorView.Style) {
        indicator.style = style
    }

    public func startAnimating(color: UIColor) {
        if #available(iOS 13.0, *) {
            setIndicatorStyle(.medium)
        } else {
            setIndicatorStyle(.gray)
        }
        indicator.color = color
        startAnimating()
    }

    public func startWhiteAnimating() {
        startAnimating(color: .white)
        startAnimating()
    }

    public func startAnimating() {
        self.indicator.startAnimating()
        self.isEnabled = false
        self.imageView?.removeFromSuperview()
        self.titleLabel?.removeFromSuperview()
    }

    public func stopAnimating() {
        self.indicator.stopAnimating()
        self.isEnabled = true
        if let imageView = self.imageView {
            self.addSubview(imageView)
        }
        if let titleLabel = self.titleLabel {
            self.addSubview(titleLabel)
        }
    }

    private func animate() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.titleLabel?.alpha = 0.5
            self?.imageView?.alpha = 0.5
            }, completion: { [weak self] (_) in
                self?.titleLabel?.alpha = 1.0
                self?.imageView?.alpha = 1.0
        })
    }

    open override func sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        animate()
        super.sendAction(action, to: target, for: event)
    }
}
