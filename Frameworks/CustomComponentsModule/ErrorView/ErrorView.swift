//
//  ErrorView.swift
//  CustomComponentsModule
//
//  Created by Ahmad Mahmoud on 12/03/2021.
//

import UIKit

public class ErrorView: BaseCustomView {
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var underlinedButton: UIButton!
    @IBOutlet private weak var stackView: UIStackView!
    //
    private var buttonAction: (() -> Void)?
    private var underlinedButtonAction: (() -> Void)?
    
    public override func initWithNib() {
        super.initWithNib()
        super.configureContent(self.contentView)
        self.actionButton.layer.cornerRadius = 23
        self.actionButton.layer.masksToBounds = true
        self.stackView.isHidden = true
    }
    
    @discardableResult
    public func showBottomItems() -> ErrorView {
        self.stackView.isHidden = false
        return self
    }
    
    @discardableResult
    public func set(headerLabel: String) -> ErrorView {
        self.headerLabel.text = headerLabel
        return self
    }
    
    @discardableResult
    public func set(infoLabel: String) -> ErrorView {
        self.infoLabel.text = infoLabel
        return self
    }
   
    @discardableResult
    public func set(bottomLabel: String) -> ErrorView {
        self.bottomLabel.text = bottomLabel
        return self
    }
    
    @discardableResult
    public func set(icon: UIImage) -> ErrorView {
        self.imageView.image = icon
        return self
    }
    
    @discardableResult
    public func set(headerTextColor: UIColor) -> ErrorView {
        self.headerLabel.textColor = headerTextColor
        return self
    }
    
    @discardableResult
    public func set(backgroundColor: UIColor) -> ErrorView {
        self.contentView.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    public func set(buttonLabel: String) -> ErrorView {
        self.actionButton.setTitle(buttonLabel, for: .normal)
        return self
    }
    
    @discardableResult
    public func buttonAction(_ buttonAction: @escaping (() -> Void)) -> ErrorView {
        self.buttonAction = buttonAction
        return self
    }
    
    @discardableResult
    public func set(underLinedButtonLabel: String) -> ErrorView {
        let attributedString = NSMutableAttributedString(string: underLinedButtonLabel)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: self.underlinedButton.titleColor(for: .normal)!, range: NSRange(location: 0, length: underLinedButtonLabel.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: self.underlinedButton.titleColor(for: .normal)!, range: NSRange(location: 0, length: underLinedButtonLabel.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: underLinedButtonLabel.count))
        self.underlinedButton.setAttributedTitle(attributedString, for: .normal)
        //
        return self
    }
    
    @discardableResult
    public func underlinedButtonAction(_ buttonAction: @escaping (() -> Void)) -> ErrorView {
        self.underlinedButtonAction = buttonAction
        return self
    }
    
    @IBAction private func actionButtonClickAction(_ sender: UIButton) {
        self.buttonAction?()
    }
    
    @IBAction private func underlinedButtonAction(_ sender: UIButton) {
        self.underlinedButtonAction?()
    }
}
