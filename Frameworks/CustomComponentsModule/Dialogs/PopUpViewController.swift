//
//  PopUpViewController.swift
//  TemplateApp
//
//  Created by Ahmad Mahmoud on 24/02/2021.
//

import UIKit
import CoreModule

public class PopUpViewController: UIViewController {
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var primaryLabel: UILabel!
    @IBOutlet private weak var secondaryLabel: UILabel!
    @IBOutlet private weak var okButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    //
    private var primaryText: String!
    private var secondaryText: String?
    private var okButtonTitle: String!
    private var cancelButtonTitle: String!
    //
    private var okButtonActionClosure: (() -> Void)?
    private var cancelButtonActionClosure: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .transparentBlack
        self.cardView.roundCorners(radius: 20)
        if(self.secondaryText == nil) {
            self.secondaryLabel.isHidden = true
        }
        else {
            self.secondaryLabel.text = self.secondaryText
        }
        self.primaryLabel.text = self.primaryText
        self.okButton.setTitle(self.okButtonTitle, for: .normal)
        self.cancelButton.setTitle(self.cancelButtonTitle, for: .normal)
        self.okButton.roundCorners(radius: 23)
        self.cancelButton.setBorder(borderWidth: 2, color: .black, cornerRadius: 23)
    }
    
    public func set(primaryText: String) -> PopUpViewController {
        self.primaryText = primaryText
        return self
    }
    
    public func set(secondaryText: String) -> PopUpViewController {
        self.secondaryText = secondaryText
        return self
    }
    
    public func set(okText: String, okButtonAction: (() -> Void)? = nil) -> PopUpViewController {
        self.okButtonTitle = okText
        self.okButtonActionClosure = okButtonAction
        return self
    }
    
    public func set(cancelText: String, cancelButtonAction: (() -> Void)? = nil) -> PopUpViewController {
        self.cancelButtonTitle = cancelText
        self.cancelButtonActionClosure = cancelButtonAction
        return self
    }
    
    @IBAction private func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func okButtonAction(_ sender: UIButton) {
        self.okButtonActionClosure?()
        self.closeButtonAction(sender)
    }
    
    @IBAction private func cancelButtonAction(_ sender: UIButton) {
        self.cancelButtonActionClosure?()
        self.closeButtonAction(sender)
    }
}

extension PopUpViewController {
    
    private static func createPopUp(from viewController: UIViewController) -> PopUpViewController {
        return PopUpViewController().apply {
            $0.modalPresentationStyle = .overCurrentContext
        }
    }
}
