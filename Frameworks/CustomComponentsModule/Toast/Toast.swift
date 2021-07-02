//
//  Toast.swift
//  CustomComponentsModule
//
//  Created by Ahmad Mahmoud on 07/05/2021.
//

import UIKit

public class Toast: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.clipsToBounds =  true
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(frame: .zero)
        self.setupUI()
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.alpha = 0.0
        self.layer.cornerRadius = 20
        self.clipsToBounds  =  true
        self.backgroundColor = .darkGray
        self.addSubview(label)
        self.setUpLabelConstraints()
    }
    
    private func setUpLabelConstraints() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        //
        let centerX = NSLayoutConstraint(item: self.label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerXWithinMargins, multiplier: 1, constant: 0)
        let labelTop = NSLayoutConstraint(item: self.label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 15)
        let labelBottom = NSLayoutConstraint(item: self.label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -15)
        self.addConstraints([centerX, labelBottom, labelTop])
    }
    
    private func addTo(parentView: UIView) {
        parentView.addSubview(self)
        let containerCenterX = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: parentView, attribute: .centerX, multiplier: 1, constant: 0)
        let containerCenterY = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: parentView, attribute: .centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self.label, attribute: .width, multiplier: 1.1, constant: 0)
        parentView.addConstraints([width, containerCenterX, containerCenterY])
    }
    
    private func hide(delay: Double) {
        UIView.animate(withDuration: 0.4, delay: delay, animations: {
            self.alpha = 0.0
            self.label.alpha = 0.0
        }, completion: { _ in self.removeFromSuperview() })
    }
    
    public static func show(_ parentView: UIView,
                            _ text: String,
                            duration: Double = 2.5,
                            font: UIFont = UIFont.systemFont(ofSize: 15)) {
        let toast = Toast()
        toast.label.text = text
        toast.label.font = font
        toast.addTo(parentView: parentView)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toast.alpha = 1.0
        }, completion: { _ in
            toast.hide(delay: duration)
        })
    }
}
