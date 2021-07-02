//
//  FPActivityLoader.swift
//  CustomComponentsModule
//
//  Created by Ahmad Mahmoud on 11/03/2021.
//
// Ref: https://github.com/punty/FPActivityIndicator

import UIKit

@IBDesignable
public class FPActivityLoader: UIView {
    
    private var strokeAnimation: CAAnimationGroup {
        return createAnimation()
    }
    
    private var rotationAnimation: CABasicAnimation {
        return createRotationAnimation()
    }
    
    private var circleLayer: CAShapeLayer = CAShapeLayer()
    
    @IBInspectable
    public var strokeColor: UIColor = UIColor.black {
        didSet {
            circleLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    @IBInspectable
    public var animating: Bool = true {
        didSet {
            updateAnimation()
        }
    }
    
    @IBInspectable
    var hideWhenNotAnimating: Bool = true {
        didSet {
            self.isHidden = (self.hideWhenNotAnimating) && (!self.animating)
        }
    }
    
    @IBInspectable
    public var lineWidth: CGFloat = CGFloat(2) {
        didSet {
            circleLayer.lineWidth = lineWidth
        }
    }
    
    @IBInspectable
    var circleTime: Double = 1.5 {
        didSet {
            circleLayer.removeAllAnimations()
            updateAnimation()
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initWithNib()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.initWithNib()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let center = CGPoint(x: bounds.size.width/2.0, y: bounds.size.height/2.0)
        let radius = min(bounds.size.width, bounds.size.height)/2.0 - circleLayer.lineWidth/2.0
        let endAngle = CGFloat(2 * Double.pi)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
        circleLayer.path = path.cgPath
        circleLayer.frame = bounds
    }
    
    private func initWithNib() {
        lineWidth = 2.0
        circleTime = 1.5
        strokeColor = UIColor.black
        layer.addSublayer(self.circleLayer)
        backgroundColor = UIColor.clear
        circleLayer.fillColor = nil
        circleLayer.lineWidth = lineWidth
        circleLayer.lineCap = CAShapeLayerLineCap.round
        circleLayer.strokeColor = strokeColor.cgColor
    }
    
    func createAnimation() -> CAAnimationGroup {
        let headAnimation = CABasicAnimation(keyPath: "strokeStart")
        headAnimation.beginTime = self.circleTime/3.0
        headAnimation.fromValue = 0
        headAnimation.toValue = 1
        headAnimation.duration = self.circleTime/1.5
        headAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        let tailAnimation = CABasicAnimation(keyPath: "strokeEnd")
        tailAnimation.fromValue = 0
        tailAnimation.toValue = 1
        tailAnimation.duration = self.circleTime/1.5
        tailAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = self.circleTime
        groupAnimation.repeatCount = Float.infinity
        groupAnimation.animations = [headAnimation, tailAnimation]
        return groupAnimation
    }
    
    private func createRotationAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = 2 * Double.pi
        animation.duration = self.circleTime
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func updateAnimation() {
        self.isHidden = (self.hideWhenNotAnimating) && (!self.animating)
        if animating {
            circleLayer.add(strokeAnimation, forKey: "strokeLineAnimation")
            circleLayer.add(rotationAnimation, forKey: "rotationAnimation")
        }
        else {
            circleLayer.removeAllAnimations()
        }
    }
    
    public override func prepareForInterfaceBuilder() {
        self.initWithNib()
    }
    
    deinit {
        circleLayer.removeAllAnimations()
        circleLayer.removeFromSuperlayer()
    }
}
