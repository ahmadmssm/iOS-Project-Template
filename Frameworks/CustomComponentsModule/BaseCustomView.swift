//
//  BaseCustomView.swift
//  CustomComponentsModule
//
//  Created by Ahmad Mahmoud on 12/03/2021.
//

import UIKit

open class BaseCustomView: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initWithNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initWithNib()
    }
    
    // Must call super when override, and the xib name must match the .swift file name.
    open func initWithNib() {
        let bundle = Bundle.init(for: Self.self)
        let className = String(describing: type(of: self))
        bundle.loadNibNamed(className, owner: self, options: nil)
    }
    
    final public func configureContent(_ view: UIView) {
        self.addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
